# OpenWRT BuildEnv Docker
Builds a docker image based on ubuntu:jammy that is able to compile OpenWRT, and uploads to hub.docker.io with the name "$DOCKER_USERNAME/openwrt-buildenv", where DOCKER_USERNAME is set in Github Repo Secrets Settings.

# Configure
Set the following Repo Screts from Github Repo Settings:
```
  DOCKER_USERNAME: The user name of hub.docker.io
  DOCKER_PASSWORD: Access token of hub.docker.io
  TMATE_ENCRYPT_PASSWORD: Password used to encrypt the TMATE SSH connection.
```

# Build
Run the Build-OpenWRT-BuildEnv-Docker-Iamge workflow from Github Repo Actions. Upon completion with success, it will upload the image to hub.docker.io, and trigger the #Test workflow.

# Test
The Test-OpenWRT-Buildenv-Docker-Iamge workflow pulls the docker image "$DOCKER_USERNAME/openwrt-buildenv" from hub.docker.io, creates a container, and with which it compiles the latest OpenWRT source code.
This workflow will be run when:
 - The Build workflow completes with success.
 - The files related with this workflow has been modified.

# Debug
When the workflow fails, it will invoke tete1030/safe-debugger-action@dev to provide the SSH access for debugging. Please read [this page](https://github.com/marketplace/actions/safe-action-debugger) for details.

