# cloud-native-dev-demo
Repository to configure OpenShift environment and deliver the demo.

## Pre-requisites

- `OC` client.
- `tkn` client.
- OpenShift cluster with admin rights.

## Environment Installation

Login into the cli where you're going to execute the installation (admin user).

Use the `install.sh`file to configure the following components:

- Gitea: repository + 2 demo projects initialized.
- CodeReady: single instance.
- Tekton: openshift pipelines operator.
- GitOps: openshift gitops operator.
- Jaeger: all in one instance.

*TODO: Configure EFK with installation file, right now must be configured manually*

Use `example.sh` file to test de demo environment with an application that will be deployed in namespacces with the prefix `zz`.

## Seesion

### Introduction

:loudspeaker: Introduction to Cloud Native Development in OpenShift - [slides](https://docs.google.com/presentation/d/1euR1cECe1J6JuJXqe7PQ7zM8XavtRUKPC-q1vXfzfAo/edit?usp=sharing) [1 to 20] :loudspeaker: 

### 1. Development Environment Demo

- Development environment Demo:
- Create a cloud native application from scratch using Quarkus
- Review Red Hat CodeReady Workspaces
- Deploy application and review Openshift manifests/resources
- Include health probes, configuration externalisation and other good practices

[Demo instructions](demos/1.develop_environment.md)

### 2. CICD Environment Demo

- Create a Tekton pipeline for CI
- Use ArgoCD for CD (GitOps introduction)
- Review S2I process and image registry

[Demo instructions](demos/2.cicd_environment.md)

### 3. Stage Environment Demo

- Review OpenShift console developer perspective
- Review EFK logging stack
- Review traces in Jaeger

[Demo instructions](demos/3.stage_environment.md)
