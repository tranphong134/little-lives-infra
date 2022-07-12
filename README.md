tranphong134 Infra
==============

## Introduction

This repository is used to deploy terraform templates.

At the time of writing, much of the code in this repo is still in use for production environments, so we still need to understand how to use it and support it until the time that we move to the next iteration of the platform.

## Contents

This repo contains code for these systems:

* Baseline templates

    These stacks power the EKS-based deployments, and come in 3-4 parts.

    - Terraform state bucket

        This is a simple terraform template which deploys the S3 bucket needed for persisting state for the environment. This is the first thing to deploy. The templates use local state (doesn't need to be persisted) and have their own `readme` file in the folder.
        
        Source: `terraform_state_bucket`

    - Baseline DNS templates

        These are for configuring Route 53 domains for baseline environments, including ACM certificates and DNS delegation. Deploying this set of templates is a one time only job and should be done after the state bucket but before the main templates.

        Source: `tls`

    - Baseline core templates

        This is where the bulk of the deployment lives, including all networking, compute and stateful resources. See the confluence page for full documentation.

    - EKS services templates

        These overlap with the core templates, and can be used to update individual ECS services as opposed to the whole core deployment. Check the `readme` for more info.

* `dev` deployment (legacy)

    Due to historical reasons, the `dev` environment has it's own terraform codebase. Dev is the environment where developer builds get automatically deployed to, however it does not resemble what we run in most production environments and uses a completely different set of templates.
    
    **_Please do not develop new features in dev, we are trying to get rid of this environment._**

    Source: `dev`

# Prerequisites

* JQ

    Install using your system package manager.

* Terraform

    Install with `tfenv` or with your system package manager. We are using Terraform version 1.0 and above.

* AWS CLI

    Download AWS CLI by running the install-aws-cli-linux.sh script (`bash scripts/install-aws-cli-linux.sh`).
    More info here: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

# Terraform Deployment Process

The process for making and deploying changes goes as follows:

* Identify which environment you need to deploy to
* Authenticate into the correct account
* Create required changes in the code
* Initialize the deployment environment using the `init.sh` script
* Create the plan and examine the changes
* Refine the code changes if required
* Apply the changes
* Merge any code changes upstream

## Identify the environment you need to deploy to

In general, we identify environments with both a `business region` and `environment name`.

Some examples:

* dev

    - Business region: `vn`

    - Environment name: `dev`

* stage

    - Business region: `vn`

    - Environment name: `stage`

* prod

    - Business region: `vn`

    - Environment name: `prod`


Input and configuration files should take the form: `"{business_region}-{environment_name}.{file_extension}"`.

Some examples:

- `vn-dev.hcl` (inputs for vn-dev)
- `vn-prod.provider.tf` (terraform provider for vn prod environment)

## Authenticate into the correct account

If you followed the steps to auto-configure your AWS CLI profiles, then you should be able to authenticate like this:

```bash
export AWS_PROFILE=
aws sso login
```

## Create required changes in the code

If you are new to Terraform, remember that Google is your friend. You can also ask your colleagues for help. These resources might be useful:

* [Terraform AWS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Initialize the deployment environment using the `init.sh` script

Go to the required folder and call the `init.sh` script, this will initialize your environment so that you can deploy changes from your machine.

```bash
# Initialize the environment to deploy to vn-dev
./init.sh -r vn -e dev
```

If the `init.sh` script runs successfully, it will download the required dependencies and configuration. Once the script completes, you will get some deployment advice on your terminal about how to generate and execute plans for this environment.

```
running a plan
terraform plan --var-file=env/vn-dev.hcl --var-file=svcs_conf/dev-svc.hcl
apply!
terraform apply --var-file=env/vn-dev.hcl --var-file=svcs_conf/dev-svc.hcl -compact-warnings
```

## Create the plan and examine the changes

To create the plan, after initializing your environment with the `init.sh` script, copy the plan command into the terminal and execute it.

`terraform plan --var-file=env/vn-prod.hcl --var-file=svcs_conf/prod-svc.hcl`

Terraform will generate a list of changes (if there are any to make) for you to examine. You can also export the plan to a file for execution later.

## Apply the changes

When you're ready to go, execute the `terraform apply` command as shown by the `init.sh` script. If you execute without the additional arguments then you will get endless prompts and the deployment will go wrong.

Terraform should lock the environment while your changes are being made. If somebody else has the lock, ask in Slack whether the lock can be lifted safely.

**_Please do not push your own changes through with targeting while ignoring other changes on the branch. This is a bad habit which will lead to us having to abandon environments due to them becoming messy and out of date. We should try and keep everything in sync with the code as much as possible._**

## Merge any code changes upstream

Once the deployment is in sync and has been tested, it is important to get the change merged into the upstream project. If this step is missed out, then your changes might be undone at a later date.

Submit a merge request in the project and post the link into our team channel in Slack!

**_Happy Terraforming! :rocket:_**
