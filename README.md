# Memcached Service Catalog

This repo contains two approaches how to get content into OpenShift

This is an implementation of memcached for TSB and APB. This is a **proof-of-concept** for the 
[OpenShift Service Catalog](https://github.com/openshift/service-catalog)

## Prerequisites

1. At least OpenShift 3.6.rc0 ([OpenShift origin v3.6.0-rc.0](https://github.com/openshift/origin/releases/tag/v3.6.0-rc.0)) and unpack it.

* memcached service via [Template Service Broker](README_TSB.md) (TSB)
* memcached service via [Ansible Playbook Bundle](README_APB.md) (APB)


## Memcached smoke test

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
