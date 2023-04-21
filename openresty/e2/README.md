Try **OpenResty customized Lua module** using docker

```
# 1. cd directory 'e2'

# 2. start OpenResty docker container
CONTAINER_NAME='CN_'$RANDOM

# X64
docker container run --name $CONTAINER_NAME -p 80:80 -d -v $(pwd)/etc/nginx:/etc/nginx -v $(pwd)/usr/local/openresty/nginx/conf:/usr/local/openresty/nginx/conf -v $(pwd)/usr/local/openresty/lualib/e2:/usr/local/openresty/lualib/e2 openresty/openresty:alpine

# Apple Silicon M1/M2
# docker container run --name $CONTAINER_NAME -p 80:80 -d -v $(pwd)/etc/nginx:/etc/nginx -v $(pwd)/usr/local/openresty/nginx/conf:/usr/local/openresty/nginx/conf -v $(pwd)/usr/local/openresty/lualib/e2:/usr/local/openresty/lualib/e2 openresty/openresty:alpine-aarch64

CONTAINER_ID=$(docker ps -aqf "name=$CONTAINER_NAME" | head -n 1)

# 3. try the link
# expect to get default OpenResty welcome page
curl http://localhost

# 4. copy the content of $(pwd)/usr/local/openresty/nginx/conf/e2.conf to $(pwd)/usr/local/openresty/nginx/conf/nginx.conf

# 5. make openresty to reload updated config
docker container exec -it $CONTAINER_ID openresty -s reload

# 6. try the link again to see the difference
# expect to get 'hello customized Lua module' page
curl http://localhost

```