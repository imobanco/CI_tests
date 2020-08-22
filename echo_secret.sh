#!/usr/bin/env bash
touch .env.ci
echo -e SECRET_KEY=${{ secrets.CI_SECRET_KEY }} >> .env.ci
echo -e OUTRO=${{ secrets.CI_OUTRO }} >> .env.ci
exit 0
