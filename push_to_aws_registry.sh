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
# ./push_to_aws_registry.sh 415844930261.dkr.ecr.us-east-1.amazonaws.com imopay-api dev-1.2.3

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_REGISTRY

docker push $AWS_REGISTRY/$IMAGE:$TAG
