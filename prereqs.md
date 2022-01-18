# Prerequisites

The following software needs to be available in the environment where you will be installing your Tanzu To Go development workstation

### Docker

You will need Docker running on your system. If you need to install it, the following software is recommended:
* **Mac/Windows**: [Docker Desktop](https://www.docker.com/products/docker-desktop)
* **Linux**: [Distro-Specific Install](https://docs.docker.com/engine/install/#server)

If you are using Docker Desktop, it is recommended that you configure Docker to allocate at least 8 GB of memory and 6 CPUs for your Tanzu environment

You will also need a container registry where you are able to publish images. You can use a public registry like DockerHub or gcr.io, or use your own instance of a registry like Harbor or Artifactory.

### Package Manager

You will need one of the following package managers to perform the install:

* **Mac/Linux**: [Homebrew](https://brew.sh/)
* **Windows**: [Chocolatey](https://chocolatey.org/install)

### Carvel

Carvel (https://carvel.dev/) is a set of open-source tools that greatly simplifies the task of configuring and deploying software to your Kubernetes cluster. We will be using the CLI tools **kapp**, **ytt**, and **vendir** for this workshop.

#### Mac/Linux

Install the Carvel tools with Homebrew:
```
brew tap vmware-tanzu/carvel
brew install kapp ytt vendir
```

#### Windows

A script `choco-nonadmin-install.ps1` has been included to provide a way to install choco without admin priviledges.

You will want to download the Carvel CLI tools individually, and add them to your PATH:

**kapp**: https://github.com/vmware-tanzu/carvel-kapp/releases/download/v0.43.0/kapp-windows-amd64.exe <br>
**ytt**: https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.38.0/ytt-windows-amd64.exe <br>
**vendir**: https://github.com/vmware-tanzu/carvel-vendir/releases/download/v0.24.0/vendir-windows-amd64.exe

[Back to Homepage](README.md)