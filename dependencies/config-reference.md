# Config File Reference

kpack uses an OCI registry to store cloud native buildpacks, and the images it creates for your apps.  You need to edit the kpack-config.yaml to customize it for your registry.  You will need to fill in your registry URL, username and password for a registry that you can push images to.  For the `kpack.builder.tag` field, you need to specify a repository path that kpack can use to store the image layers needed for the kpack service itself.

For example, if you have a Docker Hub account with username `foo` and password `bar`, you might use the following configuration settings:
```
registry:
  server: https://index.docker.io/v1/
  username: foo
  password: bar

image_prefix: foo/demo-

kpack:
  builder:
    tag: foo/builder
  languages: [java]
```

The dependencies script will retrieve the correct CLI binaries for your local system. It is important to be sure that the host and architecture are set correctly for your system:

```
vendir:
  # For installation of CLI binaries
  host:
    # os: darwin, linux, windows
    os: "darwin"
    # arch: amd64, arm64
    arch: "amd64"
```
