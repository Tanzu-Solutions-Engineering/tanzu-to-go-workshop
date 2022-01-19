#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Download installation files
VENDIR_GITHUB_API_TOKEN="<your-github-token>" \
ytt -f setup/vendir.yml \
  --data-values-file config.yaml \
  | vendir sync --chdir setup -f-

# Make binaries executable and put them in the PATH
mkdir -p bin
cp setup/vendir/binaries/kn/kn* bin/kn
cp setup/vendir/binaries/kp/kp* bin/kp
cp setup/vendir/binaries/yq/yq* bin/yq
cp setup/vendir/binaries/kubectl/kubectl bin/kubectl

chmod +x bin/*
