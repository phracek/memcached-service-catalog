# Memcached Broker

This is an implementation of a Service Broker for memcached. This is a **proof-of-concept** for the 
[OpenShift Service Catalog](https://github.com/openshift/service-catalog)

## Prerequisites

1. OpenShift at least 3.6.rc0 ([OpenShift origin v3.6.0-rc.0](https://github.com/openshift/origin/releases/tag/v3.6.0-rc.0))

## Run OpenShift with Service Catalog

To run OpenShift with Service Catalog, run oc:

```
$ sudo oc cluster up --service-catalog
```

To grant unauthenticated access to the template service broker api, run:
```
$ sudo oc adm policy add-cluster-role-to-group system:openshift:templateservicebroker-client system:authenticated system:authenticated
```

To check whether we have service-catalog with all namespaces, run command:
```
$ sudo oc get pods --all-namespaces
```

## Installing the Broker

To register the Broker with Service Catalog, create the Broker object

