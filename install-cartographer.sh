#!/bin/bash -x
SOURCE_CONTROLLER_VERSION=$(yq eval '.cartographer.source_controller_version' config.yaml)

# Install SecretGen Controller
kapp deploy --yes -a secretgen-controller -f setup/vendir/secretgen-controller

# Install Cert Manager
kapp deploy --yes -a cert-manager -f setup/vendir/cert-manager

# Install Cartographer
kapp deploy --yes -a cartographer -f setup/overlays/cartographer -f setup/vendir/cartographer

#  Install source controller,  the source part of the supply chain
kubectl create namespace gitops-toolkit --dry-run=client -o yaml | kubectl apply -f -
kapp deploy --yes -a gitops-toolkit \
  --into-ns gitops-toolkit \
  -f https://github.com/fluxcd/source-controller/releases/download/v$SOURCE_CONTROLLER_VERSION/source-controller.crds.yaml \
  -f https://github.com/fluxcd/source-controller/releases/download/v$SOURCE_CONTROLLER_VERSION/source-controller.deployment.yaml

## install sample supply chain 
ytt --data-values-file config.yaml --ignore-unknown-comments -f source-to-knative-service  | kapp deploy -y -a source-to-knative-service -f-

