# r10k_deploy

Welcome to your new module. A short overview of the generated parts can be found
in the [PDK documentation][1].

The README template below provides a starting point with details about what
information to include in your README.

## Table of Contents

- [r10k\_deploy](#r10k_deploy)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Parameters](#parameters)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Limitations](#limitations)
  - [Development](#development)
  - [Release Notes/Contributors/Etc. **Optional**](#release-notescontributorsetc-optional)

## Description

The `r10k_deploy` plan is designed to facilitate the deployment of code using r10k, a popular tool for managing Puppet environments. This plan automates the process of disabling the Puppet agent and stopping the Puppet server, deploying the code via r10k, and performing checks to ensure the consistency of the deployed code across the specified targets.

By using this plan, users can easily synchronize and manage the deployment of their Puppet code across multiple environments and systems. It provides a streamlined approach for deploying code, verifying its integrity, and ensuring the smooth operation of the Puppet infrastructure.

## Parameters

- `targets`: Specifies the targets on which the code should be deployed. This can be a single target or a collection of targets.
- `env` (optional): Specifies the environment to deploy the code to.


## Setup

### What r10k_deploy affects

The `r10k_deploy` plan primarily affects the deployment of code using r10k and the management of Puppet and Puppetserver services. It may alter the following:

- Puppet agent: The plan disables the Puppet agent during the code deployment process.
- Puppetserver: The plan stops and disables the Puppetserver service to ensure a blocking synchronization deployment.
- Code deployment: The plan deploys code using r10k, synchronizing it across the specified targets.

### Setup Requirements

There are no specific setup requirements for using the `r10k_deploy` plan. However, it assumes the availability and proper configuration of r10k and the Puppet infrastructure.


### Beginning with r10k_deploy

To get started with the `r10k_deploy` plan, follow these basic steps:

1. Ensure that r10k is properly installed and configured on the system where you will be executing the plan.
2. Make sure that the Puppet infrastructure is set up and operational, including the Puppetserver.
3. Specify the targets on which you want to deploy the code.
4. Optionally, configure the desired environment for the code deployment.
5. Execute the `r10k_deploy` plan, providing the necessary parameters.

## Usage

Include usage examples for common use cases in the **Usage** section. Show your
users how to use your module to solve problems, and be sure to include code
examples. Include three to five examples of the most important or common tasks a
user can accomplish with your module. Show users how to accomplish more complex
tasks that involve different types, classes, and functions working in tandem.

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other
warnings.

## Development

In the Development section, tell other users the ground rules for contributing
to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel are
necessary or important to include here. Please use the `##` header.

[1]: https://puppet.com/docs/pdk/latest/pdk_generating_modules.html
[2]: https://puppet.com/docs/puppet/latest/puppet_strings.html
[3]: https://puppet.com/docs/puppet/latest/puppet_strings_style.html
