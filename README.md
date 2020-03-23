<p align="center">
    <img alt="YunoHost" src="https://raw.githubusercontent.com/YunoHost/doc/master/images/logo_roundcorner.png" width="100px" />
</p>

<h1 align="center">rsync deployments for YunoHost CI</h1>
<h2 align="center">using GitHub Actions</h2>

This GitHub Action deploys your GitHub Action Workspace, totally or partially, to the Yunohost CI Apps Dev via rsync over ssh. 

This action would usually follow a build/test action which leaves deployable code in `GITHUB_WORKSPACE`.

## Example usage

```yaml
name: Checkout repo master branch and deploy to YunoHost CI

on:
  push:
    branches:
      - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: aeris-studio/yunohost-ci-deploy@yunohost-ci-apps-dev
        with:
          USERNAME: user
          DEST: /data/example_ynh
        env:
          DEPLOY_KEY: ${{ secrets.SSH_PRIVATE_KEY }} 
```

## Inputs

### USERNAME

**Mandatory**. Your username for YunoHost CI Apps Dev.
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - # ...
      - uses: aeris-studio/yunohost-ci-deploy@yunohost-ci-apps-dev
        with:
          # ...
          USERNAME: user
```

### DEST

**Mandatory**. Deployment destination path.


```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - # ...
      - uses: aeris-studio/yunohost-ci-deploy@yunohost-ci-apps-dev
        with:
          # ...
          DEST: /data/example_ynh
```

### SRC

_Optional_. Change this to deploy a smaller subset of your [GitHub workspace](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/using-environment-variables#default-environment-variables). Any value understood by `rsync` is accepted. By default, the entire workspace is deployed.

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - # ...
      - uses: aeris-studio/yunohost-ci-deploy@yunohost-ci-apps-dev
        with:
          # ...
          SRC: _site/
```

### RSYNC_OPTIONS

_Optional_. Any initial/required rsync flags, as found in the _Options Summary_ section of [rsync manual](https://linux.die.net/man/1/rsync). 

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - # ...
      - uses: aeris-studio/yunohost-ci-deploy@yunohost-ci-apps-dev
        with:
          # ...
          RSYNC_OPTIONS: -avzr --delete --exclude '.git*'
```

## Required SECRET

This action needs a `DEPLOY_KEY` secret variable. This should be the private key part of an ssh key pair. The public key part should be added to the authorized_keys file on the CI, you can ask a YunoHost Apps Team Member to add your key.

```yaml
jobs:
  # ...
  deploy:
    runs-on: ubuntu-latest
    steps:
      - # ...
      - uses: aeris-studio/yunohost-ci-deploy@yunohost-ci-apps-dev
        with:
          # ...
        env:
          DEPLOY_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
```

In this example, it is expected you create a new repo `Settings › Secrets` named `SSH_PRIVATE_KEY`, with the content of a private key, with access to the YunoHost CI Apps Dev.


## Disclaimer

If you're using GitHub Actions, you'll probably already know that it's still in limited public beta, and GitHub advise against using Actions in production. 

So, check your keys. Check your deployment paths. And use at your own risk.
