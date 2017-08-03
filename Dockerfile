FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IDkwYTg4MzNhLTcyZjctNDI1OS05OWJkLTYyNjg1NzEyYzc0YgpuYW1lOiBteS1tZW1jYWNo\
ZWQtYXBiCmltYWdlOiBkb2NrZXIuaW8vcGhyYWNlay9teS1tZW1jYWNoZWQtYXBiCmRlc2NyaXB0\
aW9uOiBNZW1jYWNoZWQgYXBiIGltcGxlbWVudGF0aW9uCmJpbmRhYmxlOiBGYWxzZQphc3luYzog\
b3B0aW9uYWwKbWV0YWRhdGE6IAogIGRvY3VtZW50YXRpb25Vcmw6IGh0dHBzOi8vd3d3Lm1lbWNh\
Y2hlZC5vcmcKICBkaXNwbGF5TmFtZTogTWVtY2FjaGVkIChBUEIpCiAgbG9uZ0Rlc2NyaXB0aW9u\
OiBBbiBhcGIgdGhhdCBkZXBsYXlzIG1lbWNhY2hlZAogIApwYXJhbWV0ZXJzOiBbXQogIApyZXF1\
aXJlZDogW10KICAK"

COPY playbooks /opt/apb/actions
COPY roles /opt/ansible/roles
RUN chown -R apb /opt/{ansible,apb} \
    && chmod -R g=u /opt/{ansible,apb}
USER apb
