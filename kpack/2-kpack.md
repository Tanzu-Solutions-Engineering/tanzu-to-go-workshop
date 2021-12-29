# Install kpack

Run the installer script from the root directory of this repo:
```
./install-kpack.sh
```

After the install, kpack will need a couple of minutes to publish some images to your registry before it is ready. You will know this process is complete when the ClusterStore and the Builder are in `Ready` status.

```
$ kubectl get clusterstore
NAME      READY
default   True

$ kubectl get builder -n default
NAME      LATESTIMAGE                                                                       READY
builder   harbor.example.com/kpack/build@sha256:0475e1c63ee5a96e33f1892541dc7ad4786f304c0   True
```
