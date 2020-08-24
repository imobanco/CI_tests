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

#for env_variable_name in $(echo "$ENV_VARIABLES"); do
#  # Não funciona! Tem que fazer em duas partes :|
#  # echo -e $env_variable_name=${!CI_"$env_variable_name"} >> "$ENV_OUTPUT_FILE_NAME"
#
#    ci_env_variable_name=CI_"$env_variable_name"
#
#    # Sobre esse if turbinado:
#    # https://stackoverflow.com/a/13864829
#    # Sobre ${!name[*]}
#    # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
#    # https://unix.stackexchange.com/a/122848
#    # What does "${!var}" mean in shell script?
#    # https://stackoverflow.com/questions/40928492/what-does-var-mean-in-shell-script
#    if [ ${!ci_env_variable_name} == 'CI_' ]; then
#        echo "The variable $env_variable_name is unset!"
#        exit 1
#    else
##        echo "The variable $env_variable_name is set to '${!ci_env_variable_name}'"
#        echo -e CI_$env_variable_name
#        echo -e CI_$env_variable_name=${!ci_env_variable_name} >> "$ENV_OUTPUT_FILE_NAME"
#    fi
#done
#
#if [ -z ${!CI_OUTRO+x} ]; then
#    echo "The variable CI_OUTRO is unset!"
#    exit 1
#else
#    echo "The variable CI_OUTRO is set to '${!CI_OUTRO}'"
#fi

#echo '---> BEGIN: cat "$ENV_OUTPUT_FILE_NAME"'
#cat "$ENV_OUTPUT_FILE_NAME"
#echo '---> END: cat "$ENV_OUTPUT_FILE_NAME"'
#
## Concatena o arquivo `.env.ci` com `.env.hardcoded`
#cat "$ENV_OUTPUT_FILE_NAME" .env.hardcoded > .env

# Limpa o arquivo temporário
#rm "$ENV_OUTPUT_FILE_NAME"
