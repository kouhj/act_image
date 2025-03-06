# act
This is a modified version of catthehacker/ubuntu:full-latest image used by nektos/act that is tailored to my needs.

# Configure
Set the following Repo Screts from Github Repo Settings:
```
  GH_PAT: Github Personal Access Token, with read & write permissions
  DK_REGISTRY: Docker registry URL, which is registry-1.docker.io if not set.
  DK_USERNAME: User name for hub.docker.com
  DK_PASSWORD: Access token for hub.docker.com
  TMATE_ENCRYPT_PASSWORD: Password used to encrypt the TMATE SSH connection.
```
