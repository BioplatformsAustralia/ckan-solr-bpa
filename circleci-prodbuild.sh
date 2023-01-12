#!/bin/bash

set -e

#
# Production (deployable) build and tests
#

# Build parameters
CKAN_VERSION=2.9
DOCKERFILE=Dockerfile.spatial

# Build/Push

pushd $SOLR_PATH_TAG

DOCKER_TAG_LATEST="bioplatformsaustralia/${DOCKER_NAME}:latest"
DOCKER_TAG_GIT="bioplatformsaustralia/${DOCKER_NAME}:${GIT_TAG}"

# Build and push latest
make build TAG_NAME_LEGACY=${DOCKER_TAG_LATEST} DOCKERFILE=${DOCKERFILE} CKAN_VERSION=${CKAN_VERSION}
make push TAG_NAME_LEGACY=${DOCKER_TAG_LATEST}

# Push version with $GIT_TAG
if [ x"$GIT_TAG" != x"" ]; then
  docker tag ${DOCKER_TAG_LATEST} ${DOCKER_TAG_GIT}
  docker push ${DOCKER_TAG_GIT}
fi

popd
