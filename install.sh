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
NS_CICD=demo-components
NS_APP_DEV=demo-dev
NS_APP_STAGE=demo-stage
GITEA_HOSTNAME=
#-----------------------------------------------------------------------------

##############################################################################
# -- EXECUTION --
#-----------------------------------------------------------------------------

info "Starting installation"
oc new-project $NS_CICD

info "Deploying and configuring GITEA"
# oc apply -f openshift-environment/01-gitea/deploy.yaml -n $NS_CICD
GITEA_HOSTNAME=$(oc get route gitea -o template --template='{{.spec.host}}' -n $NS_CICD)
# sed "s/@HOSTNAME/$GITEA_HOSTNAME/g" openshift-environment/01-gitea/configuration.yaml | oc create -f - -n $NS_CICD
# oc rollout status deployment/gitea -n $NS_CICD
sed "s/@HOSTNAME/$GITEA_HOSTNAME/g" openshift-environment/01-gitea/setup_job.yaml | oc apply -f - --wait -n $NS_CICD
oc wait --for=condition=complete job/configure-gitea --timeout=60s -n $NS_CICD
info "GITEA configuration completed!!"