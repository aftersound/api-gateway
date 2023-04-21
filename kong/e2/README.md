Try **Kong API Gateway with postgres database** as described at [Kong API Gateway with a Database](https://hub.docker.com/_/kong) using docker

```
# 1. cd directory 'e2'

# 2. start Kong docker container
# start postgres database
docker run -d --name kong-database -p 5432:5432 -e "POSTGRES_USER=kong" -e "POSTGRES_DB=kong" -e "POSTGRES_PASSWORD=kong" postgres:9.6

# initialize postgres database
docker run --rm --link kong-database:kong-database -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" -e "KONG_PG_USER=kong" -e "KONG_PG_PASSWORD=kong" kong:latest kong migrations bootstrap

# start Kong docker container which connects to the postgres database
docker run -d --name kong --link kong-database:kong-database -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" -e "KONG_PG_PASSWORD=kong" -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" -e "KONG_PROXY_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" -p 8000:8000 -p 8443:8443 -p 8001:8001 -p 8444:8444 kong:latest

# 3. try the link
# expect to get '{"message":"no Route matched with those values"}'
curl http://localhost:8000

```