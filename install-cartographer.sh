#!/bin/bash -x
export CARTOGRAPHER_PACKAGE_VERSION=$(yq eval '.package.versions.cartographer' config.yaml)
export CERT_MANAGER_PACKAGE_VERSION=$(yq eval '.package.versions.cert-manager' config.yaml)
export FLUX_PACKAGE_VERSION=$(yq eval '.package.versions.flux' config.yaml)

# Install SecretGen Controller
kapp deploy --yes -a secretgen-controller -f setup/vendir/secretgen-controller

# Install Cert Manager

tanzu package install cert-manager \
   --package-name cert-manager.community.tanzu.vmware.com \
   --version ${CERT_MANAGER_PACKAGE_VERSION}

# Install Cartographer
tanzu package install cartographer \
   --package-name cartographer.community.tanzu.vmware.com \
   --version ${CARTOGRAPHER_PACKAGE_VERSION}

#  Install source controller,  the source part of the supply chain
tanzu package install fluxcd-source-controller \
   --package-name fluxcd-source-controller.community.tanzu.vmware.com \
   --version ${FLUX_PACKAGE_VERSION}

## install sample supply chain 
ytt --data-values-file config.yaml --ignore-unknown-comments -f source-to-knative-service  | kapp deploy -y -a source-to-knative-service -f-

