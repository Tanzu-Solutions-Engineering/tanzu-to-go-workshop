#!/bin/bash -x
TBS_VERSION=$(yq eval '.tbs.version' tbs-config.yaml)
REGISTORY_USERNAME=$(yq eval '.tbs.registry.username' tbs-config.yaml)
REGISTORY_PASSWORD=$(yq eval '.tbs.registry.password' tbs-config.yaml)
REGISTORY_URL=$(yq eval '.tbs.registry.url' tbs-config.yaml)


wget https://github.com/pivotal/kpack/releases/download/v${TBS_VERSION}/release-${TBS_VERSION}.yaml
kapp deploy -y -a tbs -f release-${TBS_VERSION}.yaml
kubectl create secret docker-registry tutorial-registry-credentials \
    --docker-username=${REGISTRY_USERNAME} \
    --docker-password=${REGISTRY_PASSWORD} \
    --docker-server=${REGISTRY_URL} \
    --namespace default

ytt -f tbs-config.yaml  -f yaml | kapp deploy -y -a tbs-meta -f-

