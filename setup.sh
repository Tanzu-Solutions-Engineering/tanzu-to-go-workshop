#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# shellcheck disable=SC2155
#readonly DIR="$(cd "$(dirname "$0")" && pwd)"

# Download installation files
#VENDIR_GITHUB_API_TOKEN=<your-github-token> \
ytt -f setup/vendir.yml \
  --data-values-file setup/values.yaml \
  --data-values-file config.yaml \
  | vendir sync --chdir setup -f-

# Make binaries executable and put them in the PATH
mkdir -p bin
find setup/vendir/binaries -type f -exec cp {} bin \;
for f in bin/*; do newf=$(basename "$f") && mv "$f" bin/"${newf%%-*}"; done
for f in bin/*; do newf=$(basename "$f") && mv "$f" bin/"${newf%%_*}"; done
chmod +x bin/*
BINDIR="${PWD}"/bin
PATH="${BINDIR}":"${PATH}"

# Install credentials/RBAC
ytt -f setup/access-control \
    --data-values-file config.yaml \
    | kapp deploy -a access-control -f- --yes

# Install tools (with overlays, where appropriate)
ytt -f setup/vendir/cartographer \
    -f setup/overlays/cartographer \
    --data-values-file config.yaml \
    | kapp deploy -a cartographer -f- --yes

ytt -f setup/vendir/cert-manager \
    --data-values-file config.yaml \
    | kapp deploy -a cert-manager -f- --yes

ytt -f setup/vendir/secretgen-controller \
    --data-values-file config.yaml \
    | kapp deploy -a secretgen-controller -f- --yes

ytt -f setup/vendir/flux2 \
    --data-values-file config.yaml \
    | kapp deploy -a flux2 -f- --yes

ytt -f setup/vendir/kpack \
    --data-values-file config.yaml \
    | kapp deploy -a kpack -f- --yes