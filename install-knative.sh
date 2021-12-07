#!/bin/bash -ex
tanzu package repository add tce-repo   --url projects.registry.vmware.com/tce/main:0.9.1   --namespace tanzu-package-repo-global

## have to wait until repository is reconciled
while kubectl get packagerepository tce-repo -n tanzu-package-repo-global | kubectl get packagerepository tce-repo -n tanzu-package-repo-global | grep 'Reconcile succeeded' | wc -l | grep 1 ; [ $? -ne 0 ]; do
    echo Package Manager is not yet ready
    sleep 5s
done

tanzu package install contour --package-name contour.community.tanzu.vmware.com --version 1.18.1 -f config.yaml
tanzu package install knative-serving --package-name knative-serving.community.tanzu.vmware.com --version 0.22.0 -f config.yaml