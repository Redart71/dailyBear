#!/bin/bash


VERSION_EMQX=5.0.9

docker pull emqx/emqx:$VERSION_EMQX
#get docker image
docker run -d --name emqx -p 1883:1883 -p 8083:8083 -p 8883:8883 -p 8084:8084 -p 18083:18083 emqx/emqx:$VERSION_EMQX


