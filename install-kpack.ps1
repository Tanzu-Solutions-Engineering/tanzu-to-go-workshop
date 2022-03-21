$ENV:REGISTRY_USERNAME=$(yq eval '.registry.username' config.yaml)
$ENV:REGISTRY_PASSWORD=$(yq eval '.registry.password' config.yaml)
$ENV:REGISTRY_URL=$(yq eval '.registry.server' config.yaml)
$ENV:BUILDER_TAG=$(yq eval '.kpack.builder.tag' config.yaml)
$ENV:IMAGE_PREFIX=$(yq eval '.image_prefix' config.yaml)
$ENV:DEFAULT_REPO="$ENV:REGISTRY_URL/$ENV:IMAGE_PREFIX"default

mkdir -p generated
Copy-Item kpack/config-template.yaml -Destination generated/kpack.yaml

yq e -i '.kp_default_repository = env(DEFAULT_REPO)' generated/kpack.yaml
yq e -i '.kp_default_repository_username = env(REGISTRY_USERNAME)' generated/kpack.yaml
yq e -i '.kp_default_repository_password = env(REGISTRY_PASSWORD)' generated/kpack.yaml

tanzu package install kpack --package-name kpack.community.tanzu.vmware.com  --version 0.5.0 --values-file=generated/kpack.yaml

docker login $ENV:REGISTRY_URL -u $ENV:REGISTRY_USERNAME -p $ENV:REGISTRY_PASSWORD

bin/kp clusterstore save default -b gcr.io/paketo-buildpacks/java
bin/kp clusterstack save base --build-image paketobuildpacks/build:base-cnb --run-image paketobuildpacks/run:base-cnb

bin/kp builder save my-builder `
  --tag $ENV:REGISTRY_URL/$ENV:BUILDER_TAG `
  --stack base `
  --store default `
  --buildpack paketo-buildpacks/java `
  -n default
