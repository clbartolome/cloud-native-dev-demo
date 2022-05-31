#!/bin/bash

##############################################################################
# -- FUNCTIONS --
info() {
    printf "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
    printf "\nINFO: $@\n"
    printf "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
}
deploy_operator() # (subscription yaml file, operator name, namespace)
{
    oc apply -f $1 -n $3
    LOOP="TRUE"
    echo "waiting for operator to be in Succeeded state"
    while [ $LOOP == "TRUE" ]
    do
        # get the csv name
        RESOURCE=$(oc get subscription $2 -n $3 -o template --template '{{.status.currentCSV}}')
        # get the status of csv 
        RESP=$(oc get csv $RESOURCE -n $3  --no-headers 2>/dev/null)
        RC=$(echo $?)
        STATUS=""
        if [ "$RC" -eq 0 ]
        then
            STATUS=$(oc get csv $RESOURCE -n $3 -o template --template '{{.status.phase}}')
            RC=$(echo $?)
        fi
        # Check the CSV state
        if [ "$RC" -eq 0 ] && [ "$STATUS" == "Succeeded" ]
        then
            echo "$2 operator deployed!"
            LOOP="FALSE" 
        fi 
    done
}
#-----------------------------------------------------------------------------

##############################################################################
# -- ENVIRONMENT --
NS_CICD=demo-components
NS_CRW=demo-crw
NS_APP_DEV=demo-dev
NS_APP_STAGE=demo-stage
GITEA_HOSTNAME=
ARGO_URL=
ARGO_PASS=
#-----------------------------------------------------------------------------

##############################################################################
# -- EXECUTION --
#-----------------------------------------------------------------------------

info "Starting installation"

info "Creating namespaces"
oc new-project $NS_CICD
oc new-project $NS_CRW
oc new-project $NS_APP_DEV
oc new-project $NS_APP_STAGE

# info "Deploying and configuring GITEA"
# oc apply -f openshift-environment/01-gitea/deploy.yaml -n $NS_CICD
# GITEA_HOSTNAME=$(oc get route gitea -o template --template='{{.spec.host}}' -n $NS_CICD)
# sed "s/@HOSTNAME/$GITEA_HOSTNAME/g" openshift-environment/01-gitea/configuration.yaml | oc create -f - -n $NS_CICD
# oc rollout status deployment/gitea -n $NS_CICD
# sed "s/@HOSTNAME/$GITEA_HOSTNAME/g" openshift-environment/01-gitea/setup_job.yaml | oc apply -f - --wait -n $NS_CICD
# oc wait --for=condition=complete job/configure-gitea --timeout=60s -n $NS_CICD
# info "GITEA configuration completed!!"

# info "Deploying and configuring CRW"
# oc apply -f openshift-environment/02-codeReady_workspaces/operator_group.yaml -n $NS_CRW
# deploy_operator openshift-environment/02-codeReady_workspaces/operator_sub.yaml codeready-workspaces $NS_CRW
# oc apply -f openshift-environment/02-codeReady_workspaces/che-cluster.yaml -n $NS_CRW
# LOOP="TRUE"
# while [ $LOOP == "TRUE" ]
# do
#     sleep 5
#     STATUS=$(oc get checluster codeready-workspaces -n $NS_CRW -o template --template '{{.status.cheClusterRunning}}')
#     if [ "$STATUS" == "Available" ]
#     then
#         echo "Eclipse Che instance Available"
#         LOOP="FALSE" 
#     fi
# done
# oc get secret pull-secret -n openshift-config -o yaml | sed "s/openshift-config/$NS_CRW/g" | oc create -n $NS_CRW -f -

# info "Deploying and configuring OpenShift pipelines"
# # deploy_operator openshift-environment/03-tekton/operator_sub.yaml openshift-pipelines-operator-rh openshift-operators
# oc policy add-role-to-user edit system:serviceaccount:$NS_CICD:pipeline -n $NS_APP_DEV
# oc policy add-role-to-user edit system:serviceaccount:$NS_CICD:pipeline -n $NS_APP_STAGE
# oc policy add-role-to-user system:image-puller system:serviceaccount:$NS_APP_STAGE:default -n $NS_CICD
# oc policy add-role-to-user system:image-puller system:serviceaccount:$NS_APP_STAGE:default -n $NS_APP_DEV

info "Deploying and configuring GitOps"
deploy_operator openshift-environment/04-gitops/operator_sub.yaml openshift-gitops-operator openshift-operators
oc apply -f openshift-environment/04-gitops/roles.yaml -n $NS_APP_STAGE
ARGO_URL=$(oc get route openshift-gitops-server -ojsonpath='{.spec.host}' -n openshift-gitops)
ARGO_PASS=$(oc get secret openshift-gitops-cluster -n openshift-gitops -ojsonpath='{.data.admin\.password}' | base64 -d)




