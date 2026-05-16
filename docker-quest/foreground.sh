#!/bin/bash

git clone git@github.com:lmayala/ring-quest.git
docker build -t lotr .
docker run -d --privileged --name lotr lotr

until docker exec lotr true >/dev/null 2>&1
do
  sleep 1
done

clear

docker exec -it lotr /bin/bash
