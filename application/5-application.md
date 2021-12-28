# Onboard your application

Customize the workload.yaml file in this folder to point to the Git repo for the source you want to build, and the container repo path where you want to publish the image.

`kubectl apply -f image.yaml`

This will kick off the build process. You can follow along by tailing the logs in the `build` container of the builder pod that executes in the default namespace. Once the build is complete, you can view the URL for your application with the Knative CLI:

`kn service list`