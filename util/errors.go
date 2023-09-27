package util

import "errors"

var ErrInvalidRollNo = errors.New("REGEXP::INVALID::ROLLNO")
var ErrInvalidEmail = errors.New("REGEXP::INVALID::EMAIL")

var ErrInvalidPasswordLength = errors.New("INVALID::PASSWORD::LENGTH")
var ErrInvalidPasswordNoSpecialChars = errors.New("INVALID::PASSWORD::NOSPECIALCHAR")

var ErrEmailUnauthorised = errors.New("EMAIL::UNAUTHORISED")
var ErrDBConnectionFailed = errors.New("CHIME::CORE::MYSQL::CONNECTIONFAILED")
var ErrRedisConnectionFailed = errors.New("CHIME::CORE::REDIS::CONNECTIONFAILED")
var ErrRedisSetFailed = errors.New("CHIME::CORE::REDIS::SETFAILED")
var ErrRedisGetFailed = errors.New("CHIME::CORE::REDIS::GETFAILED")
