#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -euxo pipefail

# Deve ser chamado: ./create_ci_env.sh input_env_file_name output_env_file_name
#
# ./create_ci_env.sh .env.example .env.ci
#
# IMPORTANTE: todas as variáveis presentes no ambiente do CI devem ver prefixadas
# com CI_ para que o script funcione!
#
# grep '\S' remove linhas com espaços ou com tabs
# grep --invert-match '^#' remove linhas com comentários, ou seja que começam com #
# https://stackoverflow.com/a/57142814
# https://unix.stackexchange.com/questions/229849/indirectly-expand-variables-in-shell#comment393127_229854
# https://unix.stackexchange.com/questions/41292/variable-substitution-with-an-exclamation-mark-in-bash

ENV_SAMPLE="$1"
ENV_OUTPUT_FILE_NAME=.env.ci

ENV_VARIABLES=$(grep '\S' "$ENV_SAMPLE" | grep --invert-match '^#' | cut --delimiter='=' --fields=1)

for env_variable_name in $(echo "$ENV_VARIABLES"); do
    ci_env_variable_name=CI_"$env_variable_name"
    echo -e $env_variable_name=$ci_env_variable_name >> "$ENV_OUTPUT_FILE_NAME"
    echo -e $ci_env_variable_name >> "$ENV_OUTPUT_FILE_NAME"
done

echo -e "Testando!" >> "$ENV_OUTPUT_FILE_NAME"

echo -e $CI_SECRET_KEY >> "$ENV_OUTPUT_FILE_NAME"

echo '---> BEGIN: cat "$ENV_OUTPUT_FILE_NAME"'
cat "$ENV_OUTPUT_FILE_NAME"
echo '---> END: cat "$ENV_OUTPUT_FILE_NAME"'

# Concatena o arquivo `.env.ci` com `.env.hardcoded`
cat "$ENV_OUTPUT_FILE_NAME" .env.hardcoded > .env

# Limpa o arquivo temporário
#rm "$ENV_OUTPUT_FILE_NAME"
