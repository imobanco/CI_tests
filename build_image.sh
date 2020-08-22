#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

AWS_REGISTRY="$1"
IMAGE="$2"
TAG="$3"

# Exemplo:
# AWS_REGISTRY=415844930261.dkr.ecr.us-east-1.amazonaws.com
# IMAGE=imopay-api
# TAG=dev-1.2.3
#
# Na linha de comando executar como:
# ./build_image.sh 415844930261.dkr.ecr.us-east-1.amazonaws.com imopay-api dev-1.2.3
#
# Note: "Dockerfile.prod" é um nome hardcoded

ID=$(
     docker build \
     --quiet \
     --label org.opencontainers.image.created=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
     --label org.opencontainers.image.revision=$(git rev-parse --short HEAD) \
     --file Dockerfile.prod \
     .
    )

docker tag $ID $AWS_REGISTRY/$IMAGE:$TAG

# Checar se precisamos da tag latest, creio que não.
# docker tag $ID $AWS_REGISTRY/$IMAGE:latest
