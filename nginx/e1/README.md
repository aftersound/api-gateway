This is to try the **Serving Static Content** example in [nginx beginner guide](https://nginx.org/en/docs/beginners_guide.html) using docker

```
# 1. cd directory 'e1'

# 2. start nginx docker container
CONTAINER_NAME='CN_'$RANDOM
docker container run --name $CONTAINER_NAME -v $(pwd)/etc/nginx:/etc/nginx -v $(pwd)/data:/data -d -p 80:80 nginx:latest
CONTAINER_ID=$(docker ps -aqf "name=$CONTAINER_NAME" | head -n 1)

# 3. try the links
# expect to get default nginx page
curl http://localhost

# expect to get 404
curl http://localhost/images/nginx.png

# 4. copy the content of $(pwd)/etc/nginx/conf.d/e1.conf to $(pwd)/etc/nginx/conf.d/default.conf

# 5. make nginx to reload updated config
docker container exec -it $CONTAINER_ID nginx -s reload

# 6. try the links again to see the difference
# expect to get updated nginx page
curl http://localhost

# expect to get the image
curl http://localhost/images/nginx.png

```