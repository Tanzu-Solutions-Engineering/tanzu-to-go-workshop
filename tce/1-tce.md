# Install Tanzu Community Edition

Follow the instructions for installing the prereqs:

https://tanzucommunityedition.io/docs/latest/cli-installation/

To install TCE on your personal computer, follow the instructions here: 

https://tanzucommunityedition.io/docs/latest/docker-install-standalone/

We recommend allocating 8GB of RAM and 6 CPUs for your cluster.

-------

Note: the above instructions describe the original model for deploying into a local environment. It has a number of shortcomings that make it ultimately unsuitable. In particular, you will lose your cluster when rebooting your machine.

These docs describe the new ``standalone`` model for deploying TCE, which addresses these shortcomings and improves performance: https://github.com/vmware-tanzu/community-edition/blob/standalone-overhaul/cli/cmd/plugin/standalone-cluster/README.md

The new approach will be supported in TCE v0.10.0, which will be dropping soon. It is recommended that you use this approach.