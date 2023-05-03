Try **Apache APISIX Gateway with etcd as configuration center** as described at [How to run APISIX using etcd as configuration center](https://hub.docker.com/r/apache/apisix) using docker

```
# 1. cd directory 'e2'

# 2. create a network
docker network create api6-network --driver bridge

# 3. start etcd docker container
docker run -d --name etcd \
  --network api6-network \
  -p 2379:2379 \
  -p 2380:2380 \
  -e ALLOW_NONE_AUTHENTICATION=yes \
  -e ETCD_ADVERTISE_CLIENT_URLS=http://127.0.0.1:2379 \
  bitnami/etcd:latest

# 4. start Apache APISIX docker container
CN='api6_'$RANDOM

docker run --name $CN --network api6-network -d -p 9080:9080 -p 9180:9180 -v $(pwd)/usr/local/openresty/nginx/conf:/usr/local/openresty/nginx/conf -v $(pwd)/usr/local/apisix/conf:/usr/local/apisix/conf apache/apisix:latest

CID=$(docker ps -aqf "name=$CN" | head -n 1)

# 5. configure the Route
curl "http://127.0.0.1:9180/apisix/admin/routes/1" -X PUT -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -d '
{
  "methods": ["GET"],
  "host": "example.com",
  "uri": "/anything/*",
  "upstream": {
    "type": "roundrobin",
    "nodes": {
      "httpbin.org:80": 1
    }
  }
}'

# 6. try the request
curl -i -X GET -H "Host: example.com" "http://127.0.0.1:9080/anything/foo?arg=10"

```