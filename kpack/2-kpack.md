# Install kpack

Install kpack onto your cluster with the following command:
```kubectl apply -f https://github.com/pivotal/kpack/releases/download/v0.4.2/release-0.4.2.yaml```

Create the docker registry secret

```kp secret create registry-credentials --registry harbor.tap.amer.end2end.link --registry-user admin -n kpack```