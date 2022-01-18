$ENV:REGISTRY_USERNAME=$(yq eval '.registry.username' config.yaml)
$ENV:REGISTRY_PASSWORD=$(yq eval '.registry.password' config.yaml)
$ENV:REGISTRY_URL=$(yq eval '.registry.server' config.yaml)

kubectl create secret docker-registry registry-credentials --docker-username=$ENV:REGISTRY_USERNAME --docker-password=$ENV:REGISTRY_PASSWORD --docker-server=$ENV:REGISTRY_URL --namespace default

ytt -f setup/vendir/kpack -f setup/overlays/kpack --data-values-file config.yaml  | kapp deploy -a kpack -f- --yes
