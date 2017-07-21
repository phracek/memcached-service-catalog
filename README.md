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

The output should be:
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

```
$ sudo oc create new-app --template memcached
```