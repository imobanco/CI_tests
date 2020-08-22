#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


# Coleta do CI os segredos e escreve estes no arquivo `.env`
./create_ci_env.sh .env.example


# Constrói a imagem recebendo via linha de comando 3 parâmetros (os mesmos do `build_image.sh`, ver nele):
# ./main.sh 415844930261.dkr.ecr.us-east-1.amazonaws.com imopay-api 1.2.3
./build_image.sh "$1" "$2" "$3"


# Faz o push para o ECR
# ./push_to_aws_registry.sh "$1" "$2" "$3"
