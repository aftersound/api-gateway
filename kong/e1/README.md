Try **Kong API Gateway without a database** as described at [Kong API Gateway without a database](https://hub.docker.com/_/kong) using docker

```
# 1. cd directory 'e1'

# 2. start Kong docker container
CONTAINER_NAME='CN_'$RANDOM

docker run --name $CONTAINER_NAME -d -v $(pwd)/usr/local/kong/nginx.conf:/usr/local/kong/nginx.conf -v $(pwd)/usr/local/kong/nginx-kong.conf:/usr/local/kong/nginx-kong.conf -v $(pwd)/usr/local/kong/nginx-kong-stream.conf:/usr/local/kong/nginx-kong-stream.conf -e "KONG_DATABASE=off" -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" -e "KONG_PROXY_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" -p 8000:8000 -p 8443:8443 -p 8001:8001 -p 8444:8444 kong:latest

CONTAINER_ID=$(docker ps -aqf "name=$CONTAINER_NAME" | head -n 1)

# 3. try the link
# expect to get '{"message":"no Route matched with those values"}'
curl http://localhost:8000

```