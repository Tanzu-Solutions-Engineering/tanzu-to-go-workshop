#!/bin/bash -ex

tanzu package install contour --package-name contour.community.tanzu.vmware.com --version 1.19.1 -f config.yaml
tanzu package install knative-serving --package-name knative-serving.community.tanzu.vmware.com --version  1.0.0  -f config.yaml
