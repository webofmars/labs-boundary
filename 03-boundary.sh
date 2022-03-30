#!/bin/bash

set -eu -o pipefail
set -x

helm upgrade \
  boundary ./helm/boundary-chart/charts/boundary-chart \
  --install \
  --namespace labs --create-namespace \
  --version 0.2.1 \
  -f values/boundary.yaml
