# Tanzu To Go Workshop

#### Workshop content for creating a standalone Kubernetes development environment built entirely on open source

![img.png](images/togo.png)

Here's the recipe for a delicious, free, 100% open-source, all-natural development workstation:

* We'll start with a foundation of Tanzu Community Edition, which gives us a composable Kubernetes cluster

![img.png](images/step-tce.png)

* Next, we'll sprinkle in a dash of [kpack](https://buildpacks.io/docs/tools/kpack/), which automates the process of turning your source code into a running container.

![img.png](images/step-kpack.png)

* Time to add bold flavor with [Knative](https://knative.dev), which makes it easy to run, access, version, and scale our application

![img.png](images/step-knative.png)

* We'll blend in [Cartographer](https://cartographer.sh/), which ties it all together and keeps your software supply chain running!

![img.png](images/step-cartographer.png)

* For dessert, we'll take the source code for your favorite application, and onboard it to our new development platform!

![img.png](images/dessert.png)

## Table of Contents

[1. Install Tanzu Community Edition](tce/1-tce.md)<br>
[2. Install kpack](kpack/2-kpack.md)<br>
[3. Install Knative](knative/3-knative.md)<br>
[4. Install Cartographer](4-cartographer.md)<br>
[5. Onboard your application](application/5-application.md)
