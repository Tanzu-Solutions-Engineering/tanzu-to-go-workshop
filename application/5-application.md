# Onboard your application

Customize the image.yaml file in this folder to point to the Git repo for the source you want to build, and the container repo path where you want to publish the image.

`kubectl apply -f image.yaml`

This will kick off the build process. You can follow along by tailing the logs in the `build` container of the builder pod that executes in the default namespace. Once the build is complete, you can use Knative to deploy your application:

`kn service create [app-name] --image [container repo path for your image]`