#!/bin/bash

set -eu -o pipefail
set -x

source .env

mkdir -p "${HELM_CACHE_HOME}"
mkdir -p "${HELM_CONFIG_HOME}"
mkdir -p "${HELM_DATA_HOME}"

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add boundary-chart https://janikgar.github.io/boundary-chart
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update
