package handlers

import (
	"encoding/json"
	"net/http"

	"chime.server/db"
	"github.com/gofiber/fiber/v2"
	"github.com/redis/go-redis/v9"
	"gorm.io/gorm"
)

func AttachAuthHandlers(app *fiber.App, d *gorm.DB, rdb *redis.Client) {
	auth := app.Group("/auth")
	auth.Post("/login", loginHandler)
	auth.Post("/signup", signupHandler(d, rdb))
	auth.Post("/otp", verifyOTPHandler(d, rdb))
	auth.Post("/cred", setCredHandler(d, rdb))
}

func loginHandler(ctx *fiber.Ctx) error {
	return nil
}

type SignupBody struct {
	RollID         string `json:"roll_id"`
	InstituteEmail string `json:"email"`
	Semester       int8   `json:"semester"`
}

func signupHandler(d *gorm.DB, rdb *redis.Client) func(ctx *fiber.Ctx) error {
	return func(ctx *fiber.Ctx) error {
		var body SignupBody
		if err := ctx.BodyParser(&body); err != nil {
			println("CHIME::SERVER::/auth/signup", err)
			ctx.Status(http.StatusBadRequest)

			return nil
		}

		s := db.Student{
			RollID:         body.RollID,
			InstituteEmail: body.InstituteEmail,
			Semester:       body.Semester,
		}

		s.CreateNew(d, rdb)
		ctx.SendStatus(http.StatusCreated)

		return nil
	}
}

type VerifyOTPBody struct {
	RollID string `json:"roll_id"`
	Otp    string `json:"otp"`
}

func verifyOTPHandler(d *gorm.DB, rdb *redis.Client) func(ctx *fiber.Ctx) error {
	return func(ctx *fiber.Ctx) error {
		var body VerifyOTPBody
		if err := ctx.BodyParser(&body); err != nil {
			println("CHIME::SERVER::/auth/otp", err)
			ctx.Status(http.StatusBadRequest)

			return nil
		}

		s := db.Student{
			RollID: body.RollID,
		}
		verified := s.VerifyEmail(d, rdb, body.Otp)

		resp, _ := json.Marshal(map[string]any{
			"data": map[string]bool{
				"email_verified": verified,
			},
		})
		ctx.Status(http.StatusAccepted).Send(resp)

		return nil
	}
}

type SetCredBody struct {
	RollID   string `json:"roll_id"`
	Password string `json:"password"`
}

func setCredHandler(d *gorm.DB, rdb *redis.Client) func(ctx *fiber.Ctx) error {
	return func(ctx *fiber.Ctx) error {
		var body SetCredBody
		if err := ctx.BodyParser(&body); err != nil {
			println("CHIME::SERVER::/auth/cred", err)
			ctx.Status(http.StatusBadRequest)

			return nil
		}

		s := db.Student{
			RollID: body.RollID,
		}
		if err := s.SetCredentials(d, body.Password); err != nil {
			ctx.SendStatus(http.StatusUnauthorized)
		}

		return nil
	}
}
