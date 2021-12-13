#!/bin/bash -ex
KPACK_VERSION=$(yq eval '.kpack.version' config.yaml)
REGISTRY_USERNAME=$(yq eval '.registry.username' config.yaml)
REGISTRY_PASSWORD=$(yq eval '.registry.password' config.yaml)
REGISTRY_URL=$(yq eval '.registry.server' config.yaml)

kapp deploy -y -a kpack -f https://github.com/pivotal/kpack/releases/download/v${KPACK_VERSION}/release-${KPACK_VERSION}.yaml -n default
kubectl create secret docker-registry registry-credentials \
    --docker-username=${REGISTRY_USERNAME} \
    --docker-password=${REGISTRY_PASSWORD} \
    --docker-server=${REGISTRY_URL} \
    --namespace default

ytt --data-values-file config.yaml -f kpack/yaml --ignore-unknown-comments | kapp deploy -y -n default -a kpack-meta -f-

