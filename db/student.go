package db

import (
	"errors"
	"regexp"
	"time"
)

func (s *Student) CreateNew(
	rollID string,
	instituteEmail string,
) error {
	if match, err := regexp.MatchString(
		"^[0-9]{2}[A-Za-z]{2}[0-9]{4}$",
		rollID,
	); err != nil || !match {
		return err
	}

	if match, err := regexp.MatchString(
		"^[a-z]+.[0-9]{2}U[0-9]{5}@btech.nitdgp.ac.in$",
		instituteEmail,
	); err != nil || !match {
		return err
	}

	s.RollID = rollID
	s.InstituteEmail = instituteEmail
	s.EmailVerified = false
	s.CreatedAt = time.Now()

	return nil
}

func (s *Student) VerifyEmail() {
	s.EmailVerified = true
}

func (s *Student) SetCredentials(
	password string,
) error {
	if len(password) < 10 {
		return errors.New("password should have a min length of 10")
	}

	s.Password = password
	return nil
}
