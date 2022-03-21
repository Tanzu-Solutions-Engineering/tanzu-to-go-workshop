#!/bin/bash -ex

#tanzu package repository update tce-repo \
#  --url projects.registry.vmware.com/tce/main:0.10.1 \
#  --namespace tanzu-package-repo-global

export REGISTRY_USERNAME=$(yq eval '.registry.username' config.yaml)
export REGISTRY_PASSWORD=$(yq eval '.registry.password' config.yaml)
export REGISTRY_URL=$(yq eval '.registry.server' config.yaml)
export BUILDER_TAG=$(yq eval '.kpack.builder.tag' config.yaml)
export IMAGE_PREFIX=$(yq eval '.image_prefix' config.yaml)
export DEFAULT_REPO="$REGISTRY_URL/$IMAGE_PREFIX"default
mkdir -p generated
cp kpack/config-template.yaml generated/kpack.yaml
yq e -i '.kp_default_repository = env(DEFAULT_REPO)' generated/kpack.yaml
yq e -i '.kp_default_repository_username = env(REGISTRY_USERNAME)' generated/kpack.yaml
yq e -i '.kp_default_repository_password = env(REGISTRY_PASSWORD)' generated/kpack.yaml

tanzu package install kpack --package-name kpack.community.tanzu.vmware.com  --version 0.5.0 --values-file=generated/kpack.yaml

docker login $REGISTRY_URL -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD

bin/kp clusterstore save default -b gcr.io/paketo-buildpacks/java
bin/kp clusterstack save base --build-image paketobuildpacks/build:base-cnb --run-image paketobuildpacks/run:base-cnb

bin/kp builder save my-builder \
  --tag $REGISTRY_URL/$BUILDER_TAG \
  --stack base \
  --store default \
  --buildpack paketo-buildpacks/java \
  -n default