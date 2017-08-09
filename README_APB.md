## Run OpenShift with Ansible Service Catalog

Before running Ansible Service Catalog, modify file `run_latest_build.sh`
with proper credentials to your Docker Hub.

If you use it as user, then organization will be the same as user name. Like `phracek` in my case `https://hub.docker.com/r/phracek/`

In order to start playing with Ansible Service Broker Template, copy file `run_latest_build.sh` to folder where you download OpenShift and run a command:

```
$ sudo ./run_latest_build.sh
```

After that you are logged in as `system` user.

To check whether we hav ansible service-catalog with all namespaces, run command:
```
$ ./oc get pods --all-namespaces
```

The output will show you all APB available under your Docker Hub account should be like:
```
NAMESPACE         NAME                                  READY     STATUS      RESTARTS   AGE
ansible-service-broker   asb-1-xtdcz                           2/2       Running     0          8m
default                  docker-registry-1-2w69z               1/1       Running     0          8m
default                  persistent-volume-setup-5pb86         0/1       Completed   0          8m
default                  router-1-2m991                        1/1       Running     0          8m
service-catalog          apiserver-686283345-rfqh3             2/2       Running     0          8m
service-catalog          controller-manager-1311218843-g454h   1/1       Running     1          8m
```

Let's have a look what kind of services we have by default, run a command:
```
$ ./oc get serviceclasses --all-namespaces

```

The output should be like:

```
NAMESPACE   NAME                                    KIND
            dh-docker.io-phracek-my-memcached-apb   ServiceClass.v1alpha1.servicecatalog.k8s.io
```

## Run memcached application from Ansible Service Catalog based on service:

To create an application from Template Service Catalog template, run a command:
```
$ sudo ./oc new-app  -n ansible-service-broker --docker-image="docker.io/phracek/my-memcached-apb:latest"
```

As soon as it is done, you should be able to see an output like:
```
$ sudo ./oc new-app  -n ansible-service-broker --docker-image="docker.io/phracek/my-memcached-apb:latest"
--> Found Docker image e05e79b (5 days old) from docker.io for "docker.io/phracek/my-memcached-apb:latest"

    * An image stream will be created as "my-memcached-apb:latest" that will track this image
    * This image will be deployed in deployment config "my-memcached-apb"
    * The image does not expose any ports - if you want to load balance or send traffic to this component
      you will need to create a service with 'expose dc/my-memcached-apb --port=[port]' later

--> Creating resources ...
    imagestream "my-memcached-apb" created
    deploymentconfig "my-memcached-apb" created
--> Success
    Run 'oc status' to view your app.
$
```

Let's verify, what's going on with the application:
```
$ ./oc status
In project ansible-service-broker on server https://127.0.0.1:8443

https://asb-1338-ansible-service-broker.172.17.0.1.nip.io (reencrypt) to pod port port-1338 (svc/asb)
  dc/asb deploys 
    docker.io/ansibleplaybookbundle/ansible-service-broker:latest
    deployment #1 deployed 17 minutes ago - 1 pod
    quay.io/coreos/etcd:latest
    deployment #1 deployed 17 minutes ago - 1 pod

dc/my-memcached-apb deploys istag/my-memcached-apb:latest 
  deployment #1 running for 39 seconds - 0/1 pods (warning: 2 restarts)

1 warning identified, use 'oc status -v' to see details.
$
```
