# Install kpack

Make sure you have cloned this repo, navigate to this (kpack) directory, and edit the [kpack-config.yaml](kpack-config.yaml) to customize it for your install.

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
