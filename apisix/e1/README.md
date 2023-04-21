Try **Apache APISIX Gateway in standalone mode** as described at [How to run APISIX in stand-alone mode](https://hub.docker.com/r/apache/apisix) using docker

```
# 1. cd directory 'e1'

# 2. start Apache APISIX docker container
CN='CN_'$RANDOM

docker run --name $CN -d -p 9080:9080 -v $(pwd)/usr/local/openresty/nginx/conf:/usr/local/openresty/nginx/conf -v $(pwd)/usr/local/openresty/lualib:/usr/local/openresty/lualib -v $(pwd)/usr/local/apisix/apisix:/usr/local/apisix/apisix -v $(pwd)/usr/local/apisix/conf:/usr/local/apisix/conf -e "APISIX_STAND_ALONE=true" apache/apisix:latest

CID=$(docker ps -aqf "name=$CN" | head -n 1)

# 3. try the link
# expect to get '{"error_msg":"404 Route Not Found"}'
curl http://localhost:9080

# 4. update apisix.yaml with content in e1.yaml in directory $(pwd)/usr/local/apisix/conf

# 5. make apisix container to reload updated config
docker exec -it $CID apisix reload

# 6. try the link again to see the difference
# expect to get 'Hello APISIX'
curl http://localhost:9080

```