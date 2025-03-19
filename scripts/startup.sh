#!/bin/sh
set -e

export DOCKER_HOST=unix:///var/run/docker.sock

echo "Starting Docker..."
/usr/local/bin/dockerd-entrypoint.sh &

echo "Waiting for Docker socket..."
until [ -S /var/run/docker.sock ]; do
    sleep 3
done

if [ ! -f /var/lib/docker/.images_loaded ]; then
    echo "Loading images..."
    docker pull lmayala/nazgul
    docker tag lmayala/nazgul hide_hobbits
    docker tag lmayala/nazgul nazgul
    docker rmi lmayala/nazgul
    #docker load -i /root/nazgul.tar
    #docker tag nazgul hide_hobbits
    touch /var/lib/docker/.images_loaded
fi

/root/config.sh &

echo "Starting supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf

