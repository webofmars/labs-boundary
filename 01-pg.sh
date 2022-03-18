#!/bin/bash

set -eu -o pipefail
set -x

helm upgrade \
  postgresql bitnami/postgresql \
  --install \
  --namespace labs --create-namespace \
  --version 11.1.3 \
  -f values/pg.yaml
