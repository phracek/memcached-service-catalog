FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"bmFtZTogbXktbWVtY2FjaGVkLWFwYgppbWFnZTogZG9ja2VyLmlvL3BocmFjZWsvbXktbWVtY2Fj\
aGVkLWFwYgpkZXNjcmlwdGlvbjogbXktbWVtY2FjaGVkLWFwYiBkZXNjcmlwdGlvbgpiaW5kYWJs\
ZTogRmFsc2UKYXN5bmM6IG9wdGlvbmFsCm1ldGFkYXRhOiAKICBkb2N1bWVudGF0aW9uVXJsOiBo\
dHRwczovL2dpdGh1Yi5jb20vY29udGFpbmVyLWltYWdlcy9tZW1jYWNoZWQKICBkZXBlbmRlbmNp\
ZXM6IFsnZG9ja2VyLmlvL3BocmFjZWsvbXktbWVtY2FjaGVkLWFwYjpsYXRlc3QnXQogIGRpc3Bs\
YXlOYW1lOiBNZW1jYWNoZWQgKEFQQikKICBsb25nRGVzY3JpcHRpb246IEFuIGFwYiB0aGF0IGRl\
cGxheXMgbWVtY2FjaGVkCnBsYW5zOgotIGRlc2NyaXB0aW9uOiBNZW1jYWNoZWQgYXBiIGltcGxl\
bWVudGF0aW9uCiAgZnJlZTogdHJ1ZQogIG5hbWU6IGRlZmF1bHQKICBwYXJhbWV0ZXJzOiBbXQo="


COPY playbooks /opt/apb/actions
COPY roles /opt/ansible/roles
RUN chown -R apb /opt/{ansible,apb} \
    && chmod -R g=u /opt/{ansible,apb}
USER apb
