#!/bin/bash

IMAGE='chromium'
META_TAG='chinese'


docker buildx build --no-cache -t ${IMAGE}:${META_TAG} --platform=linux/amd64 .
