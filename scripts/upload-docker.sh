#!/bin/bash

BUILDER_NAME="${DK_IMAGE_NAME}"
BUILDER_TAG="latest"
builder_full_name="${DK_REGISTRY:+$DK_REGISTRY/}${DK_USERNAME}/${BUILDER_NAME}"
BUILDER_IMAGE_ID="${builder_full_name}:${BUILDER_TAG}"

BUILDER_CONTAINER_ID="$BUILDER_NAME"

set -xeo pipefail

echo '{
"max-concurrent-downloads": 50,
"max-concurrent-uploads": 50,
"experimental": true
}' | sudo tee /etc/docker/daemon.json

sudo service docker restart

echo "${DK_PASSWORD}" | docker login -u "${DK_USERNAME}" --password-stdin "${DK_REGISTRY}"
docker image tag "${BUILDER_NAME}"  "${BUILDER_IMAGE_ID}" 
docker push "${BUILDER_IMAGE_ID}"
docker logout "${DK_REGISTRY}"
