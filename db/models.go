package db

import (
	"fmt"
	"os"
	"time"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"

	"chime.server/util"
)

type Student struct {
	RollID         string `gorm:"primaryKey" json:"roll_id"`
	InstituteEmail string `gorm:"unique;not null" json:"email"`
	// Password       string `json:"password"`

	CreatedAt     time.Time `json:"created_at"`
	EmailVerified bool      `gorm:"not null" json:"email_verified"`

	Semester int8   `json:"semester"`
	Branch   string `json:"branch"`
}

type Subject struct {
	SubjectID   string `gorm:"primaryKey"`
	SubjectName string `gorm:"not null"`
	Semester    int8
	Branch      string

	Monday    time.Time
	Tuesday   time.Time
	Wednesday time.Time
	Thursday  time.Time
	Friday    time.Time
}

func Setup(username string, password string, dbname string) *gorm.DB {
	dsn := fmt.Sprintf(
		"%v:%v@tcp(127.0.0.1:3306)/%v?charset=utf8mb4&parseTime=True&loc=Local",
		username,
		password,
		dbname,
	)
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		println(util.ErrDBConnectionFailed.Error())
		os.Exit(1)
	}

	return db
}

func Migrate(db *gorm.DB) {
	println("CHIME::CORE::running migrations")
	db.AutoMigrate(&Student{}, &Subject{})
}
