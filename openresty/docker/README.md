Creat OpenResty docker image which supports https with let's encrypt certificate auto-refreshed

```
# 1. cd directory 'docker'

# 2. build docker image, assuming site domain name is myblog.com
docker build -t openresty --build-arg CN=myblog.com .

# 3. try to run docker image
docker run -it -p 80:80 -p 443:443 -v $(pwd)/openresty/nginx/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -v $(pwd)/_site:/usr/share/_site openresty
```

Try to visit https://localhost in browser, which might complain the certificate is not secure.  As long as you see page "Welcome to OpenResty with https certificate auto renewed!", it's fine.