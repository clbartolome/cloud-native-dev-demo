# cloud-native-dev-demo
Repository to configure OpenShift environment and deliver the demo.

## 1. Pre-requisites

- `OC` client.
- OpenShift cluster with admin rights.

## 2. Environment Installation

Login into the cli where you're going to execute the installation (admin user).

Use the `install.sh`file to configure the folloing components:
- Gitea

## 3. Demos

### 3.1 Development Environment Demo

#### 3.1.1 Create application

- Create a repository in GitHub for the demo code.

- Go to [code.quarkus.redhat.com](https://code.quarkus.redhat.com/) to generate your application:
  - Group: `com.redhat.cnd`
  - Arctifact: `rest-example`
  - Build Tool: `Maven`
  - Version: `1.0.0-SNAPSHOT`
  - Java Version: `11`
  - Starter Code: `Yes`
  - Extensions: `RESTEasy Jackson`

- Access the Gitea isntance deployed in OCP and clone `application-source` and `application-cicd` repositories. User is `gitea` and the password is `openshift`.
- Extract and copy the downloaded code into `application-source` repo:
  ```sh
  # Clone app
  mkdir  ~/Desktop/demo/
  cd ~/Desktop/demo/
  git clone http://gitea-demo-components.%APPS_CLUSTER%/gitea/application-source.git
  # Extract content
  unzip ~/Downloads/rest-example.zip
  cp -a rest-example/. application-source
  # Push new code
  cd application-source
  git add . && git commit -m "Generated quarkus app." && git push
  ```

