#!/bin/bash

username=""
password=""

while [[ $# -gt 0 ]]; do
  key="$1"
  
  case $key in
    --username)
      username="$2"
      shift
      ;;
    --password)
      password="$2"
      shift
      ;;
    *) 
      ;;
  esac
  
  shift
done


if [[ -z $username ]]; then
  read -p "username: " username
fi

if [[ -z $password ]]; then
  read -p "password: " -s password
  echo
fi

CUSTOM_PORT=3000
CUSTOM_HTTPS_PORT=3001

docker volume create chromium_config

docker run -d \
  --name=chromium \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Asia/Taipei \
  -e CUSTOM_USER=$username \
  -e PASSWORD=$password \
  -e CUSTOM_PORT=${CUSTOM_PORT} \
  -e CUSTOM_HTTPS_PORT=${CUSTOM_HTTPS_PORT} \
  -p ${CUSTOM_PORT}:${CUSTOM_PORT} \
  -p ${CUSTOM_HTTPS_PORT}:${CUSTOM_HTTPS_PORT} \
  -v chromium_config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  chromium:chinese
