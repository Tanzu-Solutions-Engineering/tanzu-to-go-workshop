#!/bin/bash -x
KPACK_VERSION=$(yq eval '.kpack.version' kpack-config.yaml)
REGISTRY_USERNAME=$(yq eval '.kpack.registry.username' kpack-config.yaml)
REGISTRY_PASSWORD=$(yq eval '.kpack.registry.password' kpack-config.yaml)
REGISTRY_URL=$(yq eval '.kpack.registry.url' kpack-config.yaml)

kapp deploy -y -a kpack -f https://github.com/pivotal/kpack/releases/download/v${KPACK_VERSION}/release-${KPACK_VERSION}.yaml -n default
kubectl create secret docker-registry registry-credentials \
    --docker-username=${REGISTRY_USERNAME} \
    --docker-password=${REGISTRY_PASSWORD} \
    --docker-server=${REGISTRY_URL} \
    --namespace default

ytt -f kpack-config.yaml -f yaml --ignore-unknown-comments | kapp deploy -y -n default -a kpack-meta -f-

