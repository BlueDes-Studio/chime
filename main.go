package main

import (
	"context"
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

	println("CHIME::CORE::REDIS::CONNECTING")
	fmt.Printf("-> HOST::%v\n", config.REDIS_HOST)
	fmt.Printf("-> PASSWORD::%v\n", config.REDIS_PASSWORD)

	rdb := config.RedisSetup()

	args := os.Args
	if len(args) > 1 && args[1] == "migrate" {
		if err := rdb.Ping(context.Background()); err != nil {
			os.Exit(1)
		}

		db.Migrate(d)
		os.Exit(0)
	}
}
