$ENV:CARTOGRAPHER_PACKAGE_VERSION='0.2.2'
$ENV:CERT_MANAGER_PACKAGE_VERSION='1.6.1'

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

# Install RBAC required by cartographer.
kapp deploy --yes -a cartographer-rbac -f setup/overlays/cartographer
#  Install source controller,  the source part of the supply chain
kubectl create namespace gitops-toolkit --dry-run=client -o yaml | kubectl apply -f -
kapp deploy --yes -a gitops-toolkit --into-ns gitops-toolkit -f setup/vendir/source-controller

## install sample supply chain 
ytt --data-values-file config.yaml --ignore-unknown-comments -f source-to-knative-service  | kapp deploy -y -a source-to-knative-service -f-

