# debug forward 
### server
```
version: '3'
services:
  http:
    image: kitsudo/debug
    restart: always
    ports:
    - "30022:30022"
    environment:
    - VIRTUAL_HOST=debug.domain.fi
    volumes:
    - ./authorized_keys:/root/.ssh/authorized_keys:ro
networks:
  default:
    external:
      name: nginx-proxy                               
```
### client
```
docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -e 'LOCAL_HOST=host.docker.internal' \
  -e 'LOCAL_PORT=9999' \
  kitsudo/debug 100.100.100.100
```