#!/usr/bin/env bash

for dir in ~/projects/*/; do
  if [ -f "${dir}/devops" ] && [ -f "${dir}/docker-compose.override.yml" ]; then
    printf "Entering ${dir} \n\n"
    cd "${dir}"
    bash -c "./devops down"
    printf "\n"
  fi
done
