# Download Dependencies

To begin, we will configure and download the software dependencies we need. Clone this Git repo onto your local system, and navigate to the root directory of the repo:

```
git clone https://github.com/Tanzu-Solutions-Engineering/tanzu-to-go-workshop
cd tanzu-to-go-workshop
```

All further installation instructions will be executed from this directory

### Customize config.yaml

There is a sample configuration file titled config-REDACTED.yaml in the root directory of this repo. Make a copy of it to edit and use for your install:

```
cp config-REDACTED.yaml config.yaml
```

Edit the file to provide the path and credentials for the docker registry you'll be using, as well as the OS and architecture for your local system. Have an instructor review the config.yaml file with you to avoid having to backtrack later.

[Config File Reference](config-reference.md)

### Fetch Dependencies

Execute the `download-dependencies.sh` script in the base directory to get the correct dependencies for your system:

```
./download-dependencies.sh
```

In addition to Kubernetes software deployments, this script will retrieve CLI binaries and add them to the `bin` subdirectory. The downloaded binaries are:
* **kn** (Knative client)
* **kp** (kpack client)
* **kubectl** (Kubernetes client)
* **yq** (YAML proccessor)

You will need to add the ```bin``` subdirectory to your PATH  to access these commands. Alternative, you can copy these CLIs into your existing path. For example, on Mac/Linux, you can run

```
sudo cp bin/* /usr/local/bin
```

[Back to Homepage](../README.md)