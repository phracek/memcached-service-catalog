## Run OpenShift with Ansible Service Catalog

In order to start playing with Ansible Service Broker Template, copy file `run_latest_build.sh` to folder where you download OpenShift and run a command:

```
$ sudo ./run_latest_build.sh
```

After that you are logged in as `system` user.

To check whether we hav ansible service-catalog with all namespaces, run command:
```
$ ./oc get pods --all-namespaces
```

The output should be like:
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
NAMESPACE   NAME                                            KIND
            dh-ansibleplaybookbundle-etherpad-apb           ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-hello-world-apb        ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-jenkins-apb            ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-mediawiki123-apb       ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-pyzip-demo-apb         ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-pyzip-demo-db-apb      ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-rhscl-mariadb-apb      ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-rhscl-postgresql-apb   ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-rocketchat-apb         ServiceClass.v1alpha1.servicecatalog.k8s.io
            dh-ansibleplaybookbundle-wordpress-ha-apb       ServiceClass.v1alpha1.servicecatalog.k8s.io

```

## Installing the memcached service into Template Service Catalog

To register memcached as service into Template Service Catalog, run a command:
```
$ sudo ./oc create -f apb.yaml -n openshift
```

To verify it, run a command:
```
$ sudo ./oc get serviceclasses -n service-catalog
```

The output should be:
```
$ ./oc get serviceclasses -n service-catalog
NAME                                            KIND
dh-ansibleplaybookbundle-etherpad-apb           ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-hello-world-apb        ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-jenkins-apb            ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-mediawiki123-apb       ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-pyzip-demo-apb         ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-pyzip-demo-db-apb      ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-rhscl-mariadb-apb      ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-rhscl-postgresql-apb   ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-rocketchat-apb         ServiceClass.v1alpha1.servicecatalog.k8s.io
dh-ansibleplaybookbundle-wordpress-ha-apb       ServiceClass.v1alpha1.servicecatalog.k8s.io
my-memcached-apb                                ServiceClass.v1alpha1.servicecatalog.k8s.io
$
```

## Run memcached application from Ansible Service Catalog based on service:

To create an application from Template Service Catalog template, run a command:
```
$ sudo ./oc new-app --template memcached
```

As soon as it is done, you should be able to see an output like:
```
$ sudo ./oc new-app --template=memcached
--> Deploying template "openshift/memcached" to project myproject

--> Creating resources ...
    imagestream "memcached" created
    deploymentconfig "memcached" created
--> Success
    Run 'oc status' to view your app.
$
```

Let's verify, what's going on with the application:
```
$ sudo ./oc status
In project My Project (myproject) on server https://127.0.0.1:8443

dc/memcached deploys docker.io/modularitycontainers/memcached:latest
  deployment #1 waiting on image

View details with 'oc describe <resource>/<name>' or list everything with 'oc get all'.
$
```
