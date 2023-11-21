# Cloud.gov CF CLI Tools

A Github action for using CF CLI tools while deploying and managing apps on [cloud.gov](https://cloud.gov).

## Usage

Follow the instructions for setting up a [cloud.gov service account](https://cloud.gov/docs/services/cloud-gov-service-account/). Store you username (CG_USERNAME) and password (CG_PASSWORD) as [encrypted secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets). 

## Sample workflow

The following is an example of a workflow that uses this action. This example shows how to deploy a simple .NET Core app to cloud.gov

```yml
name: .NET Core Deploy

on:
  pull_request:
    branches: [ {branch-name} ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Setup .NET Core
      uses: actions/setup-dotnet@v1
      with:
        dotnet-version: 3.1.101

    - name: Install dependencies
      run: dotnet restore
      
    - name: Build
      run: dotnet build 
      
  deploy:
    runs-on: ubuntu-latest
    needs: build
    
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to cloud.gov
        uses: cloud-gov/cg-cli-tools@main
        with: 
          cf_username: ${{ secrets.CG_USERNAME }}
          cf_password: ${{ secrets.CG_PASSWORD }}
          cf_org: your-org
          cf_space: your-space

```

The default action is to do a `cf push -f manifest.yml --strategy rolling`.

You can also supply:

- `cf_api:` to specify a Cloud Foundry API endpoint (instead of the default `api.fr.cloud.gov`)
- `cf_manifest:` to use a different manifest file (instead of the default `manifest.yml`)
- `cf_vars_file:` to [specify values for variables in the manifest file](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#variable-substitution)
- `cf_command:` to specify a CF sub-command to run (instead of the default `push -f $cf_manifest -vars-file $cf_vars_file --strategy rolling`)
- `command:` to specify another command altogether (for example: a script which checks if required services are present and creates them if they're missing)

## A note on versions

By default this action uses the cf CLI v8 to take advantage of some of the [new features in that version](https://docs.cloudfoundry.org/cf-cli/v8.html#new-workflows). If you need to use v7 of the CLI, you can target the `cli-v7` branch when setting up your workflow, like so: `cloud-gov/cg-cli-tools@cli-v7`

## Other options

There are other tools and utilities that you can use to deploy your application to cloud.gov. Here is a list of some of the more common options.

* https://github.com/18F/cg-deploy-action
* https://github.com/usds/cloud-gov-cli
* https://github.com/alphagov/paas-docker-cloudfoundry-tools 
* https://hub.docker.com/r/governmentpaas/cf-cli 
* https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs 
