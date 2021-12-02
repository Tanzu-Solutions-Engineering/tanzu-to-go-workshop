#!/bin/bash -x
CERT_MANAGER_VERSION=$(yq eval '.cartographer.cert_manager_version' cartographer-config.yaml)
SECRETGEN_CONTROLLER_VERSION=$(yq eval '.cartographer.secretgen_controller_version' cartographer-config.yaml)
CARTOGRAPHER_VERSION=$(yq eval '.cartographer.cartographer_version' cartographer-config.yaml)
SOURCE_CONTROLLER_VERSION=$(yq eval '.cartographer.source_controller_version' cartographer-config.yaml)

DOCKER_REPO=$(yq eval '.registry.server' cartographer-config.yaml)
DOCKER_USERNAME=$(yq eval '.registry.username' cartographer-config.yaml)
DOCKER_PASSWORD=$(yq eval '.registry.password' cartographer-config.yaml)



kubectl create secret -n cartographer-system \
  docker-registry private-registry-credentials \
  --docker-server=$DOCKER_REPO \
  --docker-username=$DOCKER_USERNAME \
  --docker-password=$DOCKER_PASSWORD


# Install SecretGen Controller

kapp deploy --yes -a secretgen-controller \
  -f https://github.com/vmware-tanzu/carvel-secretgen-controller/releases/download/v$SECRETGEN_CONTROLLER_VERSION/release.yml

# Install Cert Manager

kapp deploy --yes -a cert-manager -f https://github.com/jetstack/cert-manager/releases/download/v$CERT_MANAGER_VERSION/cert-manager.yaml

# Create Cartographer

kubectl create namespace cartographer-system --dry-run=client -o yaml | kubectl apply -f -

kapp deploy --yes -a cartographer -f https://github.com/vmware-tanzu/cartographer/releases/download/${CARTOGRAPHER_VERSION}/cartographer.yaml


kubectl create namespace gitops-toolkit --dry-run=client -o yaml | kubectl apply -f -

# THIS CLUSTERROLEBINDING IS FOR DEMO PURPOSES ONLY - THIS WILL GRANT MORE PERMISSIONS THAN NECESSARY
#
kubectl create clusterrolebinding gitops-toolkit-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=gitops-toolkit:default --dry-run=client -o yaml | kubectl apply -f -

kubectl create clusterrolebinding default-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=default:default --dry-run=client -o yaml | kubectl apply -f -

#  Install source controller,  the source part of the supply chain

kapp deploy --yes -a gitops-toolkit \
  --into-ns gitops-toolkit \
  -f https://github.com/fluxcd/source-controller/releases/download/v$SOURCE_CONTROLLER_VERSION/source-controller.crds.yaml \
  -f https://github.com/fluxcd/source-controller/releases/download/v$SOURCE_CONTROLLER_VERSION/source-controller.deployment.yaml

## install sample supply chain 

ytt --ignore-unknown-comments -f .  | kapp deploy -y -a foo -f-

