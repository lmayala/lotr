#!/bin/bash

docker run -d \
  --privileged \
  --name lotr \
  lmayala/lotr

until docker exec lotr true >/dev/null 2>&1
do
  sleep 1
done

clear

docker exec -it lotr /bin/bash
