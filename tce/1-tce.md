# Install Tanzu Community Edition

Use your system's package manager to install Tanzu Community Edition:

**Mac/Linux:**
```
brew install vmware-tanzu/tanzu/tanzu-community-edition
{HOMEBREW-INSTALL-LOCATION}/configure-tce.sh
```

When the brew install completes, it will give you the location of a post-install script to run: `{HOMEBREW-INSTALL-LOCATION}/configure-tce.sh`. Execute that script to complete the install

**Windows:**

```
choco install tanzu-community-edition
```

The `tanzu` command will be added to your `$PATH` variable automatically by Chocolatey.

___

### Install standalone plugin

Execute the following commands to install the plugin for creating local clusters:

**Mac:**
```
chmod +x ./setup/vendir/binaries/standalone/tanzu-standalone
cp -v ./setup/vendir/binaries/standalone/tanzu-standalone ~/Library/Application\ Support/tanzu-cli/tanzu-plugin-standalone
rm -rfv ~/.cache/tanzu
```

**Linux:**
```
chmod +x ./setup/vendir/binaries/standalone/tanzu-standalone
cp -v ./setup/vendir/binaries/standalone/tanzu-standalone ~/.local/share/tanzu-cli/tanzu-plugin-standalone
rm -rfv ~/.cache/tanzu
```

**Windows:**
```
cp -v ./setup/vendir/binaries/standalone/tanzu-standalone.exe ${env:localappdata}\tanzu-cli\tanzu-plugin-standalone.exe
rmdir ${env:homepath}\.cache\tanzu
```

---

**NOTE**
If you are installing via WSL2 on Windows, you need to grab the Linux Binaries.

---

### Create your Kubernetes Cluster

Tanzu Community Edition allows you to create a local Kubernetes cluster that runs inside Docker, and supports easy installation of third-party [packages](https://tanzucommunityedition.io/packages/) to customize your environment.

Let's create a cluster on your local system, and call it `tce`.

```
tanzu standalone create tce --cni=calico
```

You are ready to go when you see this message: <br>
✅ Cluster created

You can verify that your cluster is accessible by running the following command to view namespaces in your cluster:
```
kubectl get ns
```

[Back to Homepage](../README.md)
