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
docker pull "${BUILDER_IMAGE_ID}"
docker logout "${DK_REGISTRY}"

SCRIPT='/tmp/build-openwrt.sh'
cat > $SCRIPT << 'EOF'
#!/bin/bash

set -xeo pipefail

BUILD_DIR="$HOME/openwrt"
mkdir -p $BUILD_DIR
cd $BUILD_DIR
git clone https://github.com/openwrt/openwrt.git .
make oldconfig
make defconfig
make -j4

echo "::set-output name=status::success"
EOF

docker run -d -t --name "${BUILDER_NAME}" \
    -v "${GITHUB_ENV}:${GITHUB_ENV}" \
    -v "${SCRIPT}:${SCRIPT}" \
    --env GITHUB_ENV=${GITHUB_ENV} \
    "${BUILDER_IMAGE_ID}"

docker exec "${BUILDER_NAME}" /bin/bash "$SCRIPT"
    