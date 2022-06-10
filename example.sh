#!/bin/bash

##############################################################################
# -- FUNCTIONS --
info() {
    printf "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
    printf "\nINFO: $@\n"
    printf "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
}
#-----------------------------------------------------------------------------

##############################################################################
# -- ENVIRONMENT --
ZZ_CICD=zz-components
ZZ_APP_DEV=zz-dev
ZZ_APP_STAGE=zz-stage

#-----------------------------------------------------------------------------

##############################################################################
# -- EXECUTION --
#-----------------------------------------------------------------------------

info "Starting ZZ Deployment"

info "Creating namespaces"
oc new-project $ZZ_CICD
oc new-project $ZZ_APP_DEV
oc new-project $ZZ_APP_STAGE


info "Configuring OpenShift pipelines roles"
oc policy add-role-to-user edit system:serviceaccount:$ZZ_CICD:pipeline -n $ZZ_APP_DEV
oc policy add-role-to-user edit system:serviceaccount:$ZZ_CICD:pipeline -n $ZZ_APP_STAGE
oc policy add-role-to-user system:image-puller system:serviceaccount:$ZZ_APP_STAGE:default -n $ZZ_CICD
oc policy add-role-to-user system:image-puller system:serviceaccount:$ZZ_APP_STAGE:default -n $ZZ_APP_DEV

info "Configuring GitOps role"
cat << EOF | oc apply -f -
apiVersion: rbac.authorization.k8s.io/v1 
kind: RoleBinding
metadata:
  name: zz-stage-role-binding
  namespace: zz-stage
roleRef:
  apiGroup: rbac.authorization.k8s.io 
  kind: ClusterRole
  name: admin
subjects:
- kind: ServiceAccount
  name: openshift-gitops-argocd-application-controller 
  namespace: openshift-gitops
EOF

info "Deploy app in DEV"
oc new-app --name=rest-example \
  openshift/ubi8-openjdk-11:1.3~https://github.com/clbartolome/cloud-native-dev-demo --context-dir=application-source \
  -e APP_GREET="Hello from zz DEV" \
  -n $ZZ_APP_DEV

oc wait TODO

curl TODO

info "Executing pipeline"
oc apply -f application-cicd/tekton/config/ -n $ZZ_CICD
oc apply -f application-cicd/tekton/tasks/ -n $ZZ_CICD
oc apply -f application-cicd/tekton/pipelines/ -n $ZZ_CICD

oc create -f application-cicd/tekton/pipeline-runs/ci-run.yaml -n $ZZ_CICD

oc wait TODO

curl TODO

info "Creating Argo app"
oc apply -f application-cicd/deploy/argo-app.yaml

oc wait TODO

curl TODO






