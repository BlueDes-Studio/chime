package db

import (
	"bytes"
	"context"
	"fmt"
	"net/smtp"
	"regexp"
	"text/template"
	"time"

	"chime.server/config"
	"chime.server/util"
	redis "github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

func generateEmailFromToken(rollno string, token string) string {
	defer func() {
		err := recover()
		if err != nil {
			println("TEMPLATE::GENERATION::FAILED::", err)
		}
	}()

	var body bytes.Buffer
	t, err := template.ParseFiles("config/email_template.html")
	if err != nil {
		panic(err)
	}

	if err := t.Execute(&body, struct {
		Token  string
		RollNo string
	}{Token: token, RollNo: rollno}); err != nil {
		panic(err)
	}

	header := "MIME-version: 1.0;\nContent-Type: text/html; charset=\"UTF-8\";\r\n" + body.String()
	return header
}

func sendTokenToEmail(rollno string, token string, email string) {
	defer func() {
		err := recover()
		if err != nil {
			println("EMAIL::FAILED::", err)
		}
	}()

	auth := smtp.PlainAuth(
		"",
		config.GMAIL_SENDER,
		config.GMAIL_APP_PASSWORD,
		config.SMTP_HOST,
	)

	if err := smtp.SendMail(
		config.SMTP_HOST+":"+config.SMTP_PORT,
		auth,
		config.GMAIL_SENDER,
		[]string{email},
		[]byte(generateEmailFromToken(rollno, token)),
	); err != nil {
		panic(util.ErrEmailUnauthorised)
	}
}

func (s *Student) CreateNew(d *gorm.DB, rdb *redis.Client) {
	defer func() {
		err := recover()
		println("CHIME::STUDENT::CreateNew", err)
	}()

	//regex match roll id
	if match, err := regexp.MatchString(
		"^[0-9]{2}[A-Za-z]{2}[0-9]{4}$",
		s.RollID,
	); err != nil || !match {
		panic(util.ErrInvalidRollNo)
	}

	//regex match email
	if match, err := regexp.MatchString(
		"^[a-z]+.[0-9]{2}u[0-9]{5}@btech.nitdgp.ac.in$",
		s.InstituteEmail,
	); err != nil || !match {
		panic(util.ErrInvalidEmail)
	}

	//set default info
	s.EmailVerified = false
	s.CreatedAt = time.Now()

	s.Branch = s.RollID[2:4]

	//insert record into db
	go func() {
		if res := d.Create(&s); res.Error != nil {
			panic(res.Error)
		}
	}()

	//send email with token for auth
	otp := fmt.Sprint(time.Now().Nanosecond())[:5]
	go sendTokenToEmail(s.RollID, otp, s.InstituteEmail)

	//store token in redis for later auth
	go func() {
		if err := rdb.Set(context.Background(), s.RollID, otp, time.Duration(10*time.Minute)).Err(); err != nil {
			println(util.ErrRedisSetFailed.Error())
		}
	}()
}

func (s *Student) VerifyEmail(d *gorm.DB, rdb *redis.Client, otp string) bool {
	otpStored, err := rdb.Get(context.Background(), s.RollID).Result()
	if err != nil {
		println(util.ErrRedisGetFailed.Error())
		s.EmailVerified = false

		return false
	}
	s.EmailVerified = otpStored == otp

	go d.Model(s).Update("email_verified", s.EmailVerified)
	return s.EmailVerified
}

// func (s *Student) SetCredentials(
// 	d *gorm.DB,
// 	password string,
// ) error {
// 	if len(password) < 10 || len(password) > 20 {
// 		return util.ErrInvalidPasswordLength
// 	}
//
// 	if match, err := regexp.MatchString(
// 		"[`!@#$%^&*()_+\\-=\\[\\]{};:|,.<>?~]",
// 		password,
// 	); err != nil || !match {
// 		return util.ErrInvalidPasswordNoSpecialChars
// 	}
//
// 	s.Password = password
// 	go d.Model(s).Update("password", s.Password)
//
// 	return nil
// }
