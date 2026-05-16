#!/bin/bash

git clone https://github.com/lmayala/ring-quest.git
cd ring-quest
docker build -t quest .
docker run -d --privileged --name quest quest

