# Onboard your application

In the application subdirectory, you will find a [workload.yaml](workload.yaml) file. It describes a Workload with the name `tanzu-java-web-app`, and it references application source code located on Github at https://github.com/sample-accelerators/tanzu-java-web-app

You have a few options on how to use your new environment:

1. Leave the workload.yaml as is, and submit it for build and deploy.
2. Fork the repo referenced in workload.yaml, and update the `spec.source.git.url` field in workload.yaml to point to your new repo. This will allow you to make subsequent updates to the code to use an iterative development process
3. Update the `spec.source.git` configuration in workload.yaml to point to an application of your choosing. This application must be in one of the languages specified in the `kpack.languages` field of the config.yaml that you used to install Tanzu.

Once your workload.yaml is ready, you can submit it:

`kubectl apply -f application/workload.yaml`

This will kick off the build process. You can follow along by tailing the logs in kpack. For example, if your workload name is `tanzu-java-webapp`, you can see the logs at:

```
kp build logs tanzu-java-web-app
```

Once the build is complete, Knative will begin the process of deploying your application. You can track the progrss of the deployment with:

```
kn service list
```

Once the service is ready, you can access your application on port **8080** of the specified URL (Be sure your [port-forward](../knative/3-knative.md) is still running).

Committing updates to the Git repo will trigger a new build and deploy of your application, allowing you to iterate.
