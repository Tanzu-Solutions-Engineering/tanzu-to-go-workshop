# Install Tanzu Community Edition

Follow the instructions for installing the prereqs:

https://tanzucommunityedition.io/docs/latest/cli-installation/

To install TCE on your personal computer, follow the instructions here: 

https://github.com/vmware-tanzu/community-edition/blob/standalone-overhaul/cli/cmd/plugin/standalone-cluster/README.md

We recommend allocating 8GB of RAM and 6 CPUs for your cluster.

Once the standalone plugin has been installed for your Tanzu CLI, you can create the cluster:

`tanzu standalone create local-tce`

You are ready to go when you see this message: <br>
✅ Cluster created

Once the cluster is available, we will install the Tanzu Community Edition package repository. This will give us easy access to perform a managed install of software dependencies onto the cluster:

`tanzu package repository add tce-repo \
--url projects.registry.vmware.com/tce/main:0.9.1 \
--namespace tanzu-package-repo-global`