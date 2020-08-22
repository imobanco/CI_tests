#!/usr/bin/env bash

echo "Teste" "$var" "$var_2"

echo env_variable_name=${{ secrets.CI_SECRET_KEY }} > file.txt
cat file.txt