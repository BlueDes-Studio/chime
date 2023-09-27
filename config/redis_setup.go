package config

import (
	"os"

	"chime.server/util"
	redis "github.com/redis/go-redis/v9"
)

func RedisSetup() *redis.Client {
	var rdb = redis.NewClient(&redis.Options{
		Addr:     REDIS_HOST,
		Password: REDIS_PASSWORD, // no password set
		DB:       0,              // use default DB
	})

	if rdb == nil {
		println(util.ErrRedisConnectionFailed.Error())
		os.Exit(1)
	}
	return rdb
}
