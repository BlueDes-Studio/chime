package main

import (
	"fmt"
	"os"

	"chime.server/config"
	"chime.server/db"
)

func main() {
	println("CHIME::CORE::MYSQL::CONNECTING")
	fmt.Printf("-> USERNAME::%v\n", config.DB_USERNAME)
	fmt.Printf("-> PASSWORD::%v\n", config.DB_PASSWORD)
	fmt.Printf("-> DATABASE::%v\n", config.DB_DATABASE)

	d := db.Setup(config.DB_USERNAME, config.DB_PASSWORD, config.DB_DATABASE)

	args := os.Args
	if len(args) > 1 && args[1] == "migrate" {
		db.Migrate(d)
		return
	}

	user := db.Student{
		RollID:         "21CS8008",
		InstituteEmail: "ssr.21u10018@btech.nitdgp.ac.in",
		Semester:       5,
	}
	user.CreateNew(d)
}
