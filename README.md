# cloud-native-dev-demo
Repository to configure OpenShift environment and deliver the demo.

## Pre-requisites

- `OC` client.
- `tkn` client.
- OpenShift cluster with admin rights.

## 2. Environment Installation

Login into the cli where you're going to execute the installation (admin user).

Use the `install.sh`file to configure the folloing components:

- Gitea
- CodeReady
- Tekton
- GitOps
- Jaeger

## Demos

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

