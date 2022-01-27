If present the environment variables from the workload will be passed to both the build and running container.

```
apiVersion: carto.run/v1alpha1
kind: Workload
metadata:
  name: tanzu-java-web-app
  labels:
    apps.tanzu.vmware.com/workload-type: web
    app.kubernetes.io/part-of: tanzu-java-web-app
spec:
  env:
    - name: runtime
      value: somevalue
  build:
    env:
     - name: foo
       value: bar
  source:
    git:
      url: https://github.com/sample-accelerators/tanzu-java-web-app
      ref:
        branch: main
```