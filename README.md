# Memcached Service Catalog

This is an implementation of a Service Broker for memcached. This is a **proof-of-concept** for the 
[OpenShift Service Catalog](https://github.com/openshift/service-catalog)

## Prerequisites

1. OpenShift at least 3.6.rc0 ([OpenShift origin v3.6.0-rc.0](https://github.com/openshift/origin/releases/tag/v3.6.0-rc.0))

## Run OpenShift with Service Catalog

To run OpenShift with Service Catalog, run oc:

```
$ sudo oc cluster up --service-catalog=true --loglevel=2
```

Switch to system user:

```
$ sudo oc login -u system:admin
```

To grant unauthenticated access to the template service broker api, run:
```
$ sudo oc adm policy add-cluster-role-to-group system:openshift:templateservicebroker-client system:unauthenticated system:authenticated
```

To check whether we have service-catalog with all namespaces, run command:
```
$ sudo oc get pods --all-namespaces
```

The output should be like:
```
NAMESPACE         NAME                                  READY     STATUS      RESTARTS   AGE
default           docker-registry-1-dbbh0               1/1       Running     0          3m
default           persistent-volume-setup-ts01h         0/1       Completed   0          3m
default           router-1-m1cgg                        1/1       Running     0          3m
service-catalog   apiserver-882628510-2bz8k             2/2       Running     0          3m
service-catalog   controller-manager-1311218843-b1s4j   1/1       Running     1          3m

```

Let's have a look what kind of services we have by default, run a command:
```
$ sudo oc get serviceclasses --all-namespaces

```

The output should be like:

```
NAME                       KIND
cakephp-mysql-persistent   ServiceClass.v1alpha1.servicecatalog.k8s.io
dancer-mysql-persistent    ServiceClass.v1alpha1.servicecatalog.k8s.io
django-psql-persistent     ServiceClass.v1alpha1.servicecatalog.k8s.io
jenkins-ephemeral          ServiceClass.v1alpha1.servicecatalog.k8s.io
jenkins-persistent         ServiceClass.v1alpha1.servicecatalog.k8s.io
jenkins-pipeline-example   ServiceClass.v1alpha1.servicecatalog.k8s.io
mariadb-persistent         ServiceClass.v1alpha1.servicecatalog.k8s.io
mongodb-persistent         ServiceClass.v1alpha1.servicecatalog.k8s.io
mysql-persistent           ServiceClass.v1alpha1.servicecatalog.k8s.io
nodejs-mongo-persistent    ServiceClass.v1alpha1.servicecatalog.k8s.io
postgresql-persistent      ServiceClass.v1alpha1.servicecatalog.k8s.io
rails-pgsql-persistent     ServiceClass.v1alpha1.servicecatalog.k8s.io

```
## Installing the memcached service into Service Catalog

To register memcached as service into Service Catalog, run a command:
```
$ sudo ./oc create -f openshift-template.yaml -n openshift
```

To verify it, run a command:
```
$ sudo ./oc get serviceclasses -n service-catalog
```

After a couple time, the output should be:
```
$ sudo ./oc get serviceclasses -n service-catalog
NAME                       KIND
cakephp-mysql-persistent   ServiceClass.v1alpha1.servicecatalog.k8s.io
dancer-mysql-persistent    ServiceClass.v1alpha1.servicecatalog.k8s.io
django-psql-persistent     ServiceClass.v1alpha1.servicecatalog.k8s.io
jenkins-ephemeral          ServiceClass.v1alpha1.servicecatalog.k8s.io
jenkins-persistent         ServiceClass.v1alpha1.servicecatalog.k8s.io
jenkins-pipeline-example   ServiceClass.v1alpha1.servicecatalog.k8s.io
mariadb-persistent         ServiceClass.v1alpha1.servicecatalog.k8s.io
memcached                  ServiceClass.v1alpha1.servicecatalog.k8s.io
mongodb-persistent         ServiceClass.v1alpha1.servicecatalog.k8s.io
mysql-persistent           ServiceClass.v1alpha1.servicecatalog.k8s.io
nodejs-mongo-persistent    ServiceClass.v1alpha1.servicecatalog.k8s.io
postgresql-persistent      ServiceClass.v1alpha1.servicecatalog.k8s.io
rails-pgsql-persistent     ServiceClass.v1alpha1.servicecatalog.k8s.io
$
```

## Run memcached application from Service Catalog based on service:

To create an application from Service Catalog template, run a command:
```
$ sudo oc new-app --template memcached
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
To deploy an image, run a command:
```
$ sudo ./oc deploy memcached
```

The last step is to verify, whether memcached is really working.

```
$ sudo ./oc get pods
NAME                READY     STATUS    RESTARTS   AGE
memcached-1-600m8   1/1       Running   0          30m
$
```

Get the IP of memcached
```
$ sudo ./oc get -o wide pod memcached-1-600m8
NAME                READY     STATUS    RESTARTS   AGE       IP           NODE
memcached-1-600m8   1/1       Running   0          30m       172.17.0.5   localhost
$
```

Test whether memcached works properly:

```
set Test 0 100 10
JournalDev
STORED - output of memcached
get Test
VALUE Test 0 10  - output of memcached
JournalDev  - output of memcached
END  - output of memcached
replace Test 0 100 4
Temp
STORED  - output of memcached
get Test
VALUE Test 0 4  - output of memcached
Temp  - output of memcached
END  - output of memcached
version
VERSION 1.4.25  - output of memcached
quit

```