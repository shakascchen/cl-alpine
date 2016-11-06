#!/bin/bash

set -eu

name=eshamster/cl-base
ver=1.0

docker rmi $(docker images | awk '/^<none>/ { print $3 }') || echo "ignore rmi error"
docker rm `docker ps -a -q` || echo "ignore rm error"

docker build -t ${name}:${ver} -t  ${name}:latest .
docker run -v /tmp/temp-mount:/tmp/temp -it ${name}:${ver} /bin/bash
