#!/bin/bash

echo "Building environment...."
until docker exec quest true >/dev/null 2>&1
do
  sleep 1
done

clear
docker exec -it quest /bin/bash
