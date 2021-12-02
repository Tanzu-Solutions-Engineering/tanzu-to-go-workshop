# Install kpack

The install process for kpack requires Carvel tools to be install

Make sure you have cloned this repo, navigate to this (kpack) directory.
```
git clone https://github.com/Tanzu-Solutions-Engineering/tanzu-to-go-workshop
cd tanzu-to-go-workshop/kpack
```

kpack uses an OCI registry to store cloud native buildpacks, and the images it creates for your apps.  You need to edit the kpack-config.yaml to customize it for your registry.  You will need to fill in your registry URL, username and password for a registry that you can push images to.  For the `kpack.builder.tag` field, you need to specify a repository path that kpack can use to store the image layers needed for the kpack service itself.

For example, if you have a Docker Hub account with username `foo` and password `bar`, you might use the following configuration settings:
```
#@data/values
---
kpack:
  version: 0.4.3
  registry:
    username: foo
    password: bar
    url: https://index.docker.io/v1/
  builder:
    tag: foo/build-service
  languages: [java]
```
Run the installer script:
```./install-kpack.sh```

kpack will need to publish some images to your registry before it is ready. Once the install is complete, you can verify that the ClusterStore and the Builder are in `Ready` status.

```
$ kubectl get clusterstore
NAME      READY
default   True

$ kubectl get builder -n default
NAME      LATESTIMAGE                                                                                                        READY
builder   harbor.tap.amer.end2end.link/kpack/build@sha256:0475e1c63ee5a96e33f1892541dc7ad4786f304c08b486c550bb362e345a16a6   True
```
