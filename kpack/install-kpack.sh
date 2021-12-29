#!/bin/bash -ex
REGISTRY_USERNAME=$(yq eval '.registry.username' config.yaml)
REGISTRY_PASSWORD=$(yq eval '.registry.password' config.yaml)
REGISTRY_URL=$(yq eval '.registry.server' config.yaml)

kubectl create secret docker-registry registry-credentials \
    --docker-username=${REGISTRY_USERNAME} \
    --docker-password=${REGISTRY_PASSWORD} \
    --docker-server=${REGISTRY_URL} \
    --namespace default

ytt -f setup/vendir/kpack \
    -f setup/overlays/kpack \
    --data-values-file config.yaml \
    | kapp deploy -a kpack -f- --yes