$ENV:CARTOGRAPHER_PACKAGE_VERSION='0.2.2'
$ENV:CERT_MANAGER_PACKAGE_VERSION='1.6.1'
$ENV:FLUX_PACKAGE_VERSION=$(yq eval '.package.versions.flux' config.yaml)

# Install SecretGen Controller

kapp deploy --yes -a secretgen-controller -f setup/vendir/secretgen-controller

# Install Cert Manager

tanzu package install cert-manager \
   --package-name cert-manager.community.tanzu.vmware.com \
   --version $ENV:CERT_MANAGER_PACKAGE_VERSION

# Install Cartographer
tanzu package install cartographer \
   --package-name cartographer.community.tanzu.vmware.com \
   --version $ENV:CARTOGRAPHER_PACKAGE_VERSION
#  Install source controller,  the source part of the supply chain
tanzu package install fluxcd-source-controller \
   --package-name fluxcd-source-controller.community.tanzu.vmware.com \
   --version $ENV:FLUX_PACKAGE_VERSION

## install sample supply chain 
ytt --data-values-file config.yaml --ignore-unknown-comments -f source-to-knative-service  | kapp deploy -y -a source-to-knative-service -f-

