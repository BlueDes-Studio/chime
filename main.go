package main

import (
	"fmt"
	"os"

	"chime.server/db"
)

func main() {
	println("CHIME::CORE::MYSQL::CONNECTING")
	fmt.Printf("-> USERNAME::%v\n", DB_USERNAME)
	fmt.Printf("-> PASSWORD::%v\n", DB_PASSWORD)
	fmt.Printf("-> DATABASE::%v\n", DB_DATABASE)

	d := db.Setup(DB_USERNAME, DB_PASSWORD, DB_DATABASE)

	args := os.Args
	if len(args) > 1 && args[1] == "migrate" {
		db.Migrate(d)
	}
}
