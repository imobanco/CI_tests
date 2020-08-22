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

RUN_SCRIPT_ECHO_SECRET=echo_secret.sh

echo -e '#!/usr/bin/env bash' > "$RUN_SCRIPT_ECHO_SECRET"
#echo -e 'set -euxo pipefail' >> "$RUN_SCRIPT_ECHO_SECRET"

echo 'touch '"$ENV_OUTPUT_FILE_NAME" >> "$RUN_SCRIPT_ECHO_SECRET"

ENV_VARIABLES=$(grep '\S' "$ENV_SAMPLE" | grep --invert-match '^#' | cut --delimiter='=' --fields=1)

for env_variable_name in $(echo "$ENV_VARIABLES"); do
    ci_env_variable_name=secrets.CI_"$env_variable_name"
    echo 'echo -e '$env_variable_name'=${{ '"$ci_env_variable_name"' }} >> '"$ENV_OUTPUT_FILE_NAME" >> "$RUN_SCRIPT_ECHO_SECRET"
done

echo -e 'exit 0' >> "$RUN_SCRIPT_ECHO_SECRET"

chmod +x echo_secret.sh

cat echo_secret.sh

./echo_secret.sh

# Concatena o arquivo `.env.ci` com `.env.hardcoded`
cat "$ENV_OUTPUT_FILE_NAME" .env.hardcoded > .env

# Limpa o arquivo temporário
# rm "$ENV_OUTPUT_FILE_NAME"
