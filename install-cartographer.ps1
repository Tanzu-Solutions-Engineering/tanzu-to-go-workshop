# Install SecretGen Controller
kapp deploy --yes -a secretgen-controller -f setup/vendir/secretgen-controller

# Install Cert Manager
kapp deploy --yes -a cert-manager -f setup/vendir/cert-manager

# Install Cartographer
kapp deploy --yes -a cartographer -f setup/overlays/cartographer -f setup/vendir/cartographer

#  Install source controller,  the source part of the supply chain
kubectl create namespace gitops-toolkit --dry-run=client -o yaml | kubectl apply -f -
kapp deploy --yes -a gitops-toolkit --into-ns gitops-toolkit -f setup/vendir/source-controller

## install sample supply chain 
ytt --data-values-file config.yaml --ignore-unknown-comments -f source-to-knative-service  | kapp deploy -y -a source-to-knative-service -f-

