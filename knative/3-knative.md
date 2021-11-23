# Install Knative

First, we will install Contour. For a personal computer install, we set Contour to use a ClusterIP endpoint because there will not be a LoadBalancer available:

```tanzu package install contour --package-name contour.community.tanzu.vmware.com --version 1.18.1 -f values-contour.yaml```

Whenever you want to access applications using Contour ingress, you will need a port forward to send localhost traffic to envoy. You can do this with the following command:

```kubectl port-forward svc/envoy 8080:80 -n projectcontour```

Now, we can install Knative. To simplify DNS we will set our Knative DNS Domain to 127-0-0-1.nip.io. This will automatically route requests to localhost, where your port forward will send them to Contour:

```tanzu package install knative-serving --package-name knative-serving.community.tanzu.vmware.com --version 0.22.0 -f values-knative.yaml```

### Validating the install

You can verify everything works so far by creating a Knative service:

kn service create helloworld-go --image gcr.io/knative-samples/helloworld-go

When the service is available, you should be able to access it in your browser through the port-forward: http://helloworld-go.default.127-0-0-1.nip.io:8080