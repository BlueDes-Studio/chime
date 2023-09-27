package db

import "errors"

var ErrInvalidRollNo = errors.New("REGEXP::INVALID::ROLLNO")
var ErrInvalidEmail = errors.New("REGEXP::INVALID::EMAIL")

var ErrInvalidPasswordLength = errors.New("INVALID::PASSWORD::LENGTH")
var ErrInvalidPasswordNoSpecialChars = errors.New("INVALID::PASSWORD::NOSPECIALCHAR")

var ErrEmailUnauthorised = errors.New("EMAIL::UNAUTHORISED")
