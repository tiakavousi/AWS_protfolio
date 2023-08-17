This project is intended to create AWS infrastructure using Terraform (IaC) as part of the IU University Cloud Programming course.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Setup](#setup)
- [Destroy](#destroy)

## Prerequisites

- Ensure you have an active AWS account or access key, configured with the following permissions:
  - AdministratorAccess
  - AmazonS3FullAccess
  - NetworkAdministrator
  - SystemAdministrator
- Terraform installed.
- Default RSA ssh key pairs (`~/.ssh/id_rsa` `~/.ssh/id_rsa.pub`)


## Configuration:

```
export TF_VAR_aws_region="us-east-1"
export AWS_SECRET_ACCESS_KEY="<YOUR-AWS-SECRET-KEY>"
export AWS_ACCESS_KEY_ID="<YOUR-AWS-ACCESS-KEY-ID>"
```

## Setup

```
terraform init
terraform plan
terraform apply
```

## Destroy
```
terraform destroy
```
