package db

import (
	"bytes"
	"fmt"
	"net/smtp"
	"regexp"
	"text/template"
	"time"

	"chime.server/config"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

func generateEmailFromToken(token string) string {
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

	if err := t.Execute(&body, struct{ Token string }{Token: token}); err != nil {
		panic(err)
	}

	header := "MIME-version: 1.0;\nContent-Type: text/html; charset=\"UTF-8\";\r\n" + body.String()
	return header
}

func sendTokenToEmail(token string, email string) {
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
		[]byte(generateEmailFromToken(token)),
	); err != nil {
		panic(ErrEmailUnauthorised)
	}
}

func (s *Student) CreateNew(d *gorm.DB) error {
	//regex match roll id
	if match, err := regexp.MatchString(
		"^[0-9]{2}[A-Za-z]{2}[0-9]{4}$",
		s.RollID,
	); err != nil || !match {
		return ErrInvalidRollNo
	}

	//regex match email
	if match, err := regexp.MatchString(
		"^[a-z]+.[0-9]{2}u[0-9]{5}@btech.nitdgp.ac.in$",
		s.InstituteEmail,
	); err != nil || !match {
		return ErrInvalidEmail
	}

	//set default info
	s.EmailVerified = false
	s.CreatedAt = time.Now()

	s.Branch = s.RollID[2:4]

	//insert record into db
	res := d.Create(&s)
	if res.Error != nil {
		return res.Error
	}

	//send email with token for auth
	otp := fmt.Sprint(time.Now().Nanosecond())[:6]
	go sendTokenToEmail(otp, s.InstituteEmail)

	return nil
}

func (s *Student) VerifyEmail() {
	s.EmailVerified = true
}

func (s *Student) SetCredentials(
	password string,
) error {
	if len(password) < 10 || len(password) > 20 {
		return ErrInvalidPasswordLength
	}

	if match, err := regexp.MatchString(
		"[`!@#$%^&*()_+\\-=\\[\\]{};:|,.<>?~]",
		password,
	); err != nil || !match {
		return ErrInvalidPasswordNoSpecialChars
	}

	s.Password = password

	return nil
}
