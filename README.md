# Memcached Broker

This is an implementation of a Service Broker for memcached. This is a **proof-of-concept** for the 
[OpenShift Service Catalog](https://github.com/openshift/service-catalog)

## Prerequisites

1. OpenShift at least 3.6.rc0 ([OpenShift origin v3.6.0-rc.0](https://github.com/openshift/origin/releases/tag/v3.6.0-rc.0))

## Run OpenShift with Service Catalog

To run OpenShift with Service Catalog, run oc:

```
$ sudo oc cluster up --service-catalog=true
```

Switch to admin user:

```bash
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

The output would be like:
```bash
NAMESPACE         NAME                                  READY     STATUS      RESTARTS   AGE
default           docker-registry-1-dbbh0               1/1       Running     0          3m
default           persistent-volume-setup-ts01h         0/1       Completed   0          3m
default           router-1-m1cgg                        1/1       Running     0          3m
service-catalog   apiserver-882628510-2bz8k             2/2       Running     0          3m
service-catalog   controller-manager-1311218843-b1s4j   1/1       Running     1          3m

```
## Installing the Broker

To register the Broker with Service Catalog, create the Broker object
```bash
$ sudo ./oc create -f examples/memcached-broker -n service-catalog
```

To verify it, run a command:
```bash
$ sudo ./oc get serviceclasses -n service-catalog
```