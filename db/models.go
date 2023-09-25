package db

import (
	"fmt"
	"time"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

type Student struct {
	RollID         string `gorm:"primaryKey"`
	InstituteEmail string `gorm:"unique;not null"`
	Password       string

	CreatedAt     time.Time
	EmailVerified bool `gorm:"not null"`

	Semester int8
	Branch   string
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
		return nil
	}

	return db
}

func Migrate(db *gorm.DB) {
	println("CHIME::CORE::running migrations")
	db.AutoMigrate(&Student{}, &Subject{})
}
