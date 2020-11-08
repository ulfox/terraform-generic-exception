# Terraerror

Terraform module for raising exceptions on condition

## Generic Shell Example

```hcl
module "raise_error_instance_type" {
  source            = "github.com/ulfox/terraform-generic-exception.git?ref=v0.0.1"
  shell_condition   = "echo ${var.bastion_instance_type} | grep -iE '(t[0-9]+)\.([a-z]+)'"
  message           = "Wrong Instance Type"
}

resource "aws_instance" "bastion" {
  ami                         = local.bastion_ami_id
  instance_type               = var.bastion_instance_type
  ...
  depends_on = [
    module.raise_error_instance_type
  ]
}
```

## Comparison Example

```hcl
module "raise_error_region" {
  source            = "github.com/ulfox/terraform-generic-exception.git?ref=v0.0.1"
  condition         = [var.region, "==", "eu-west-1"]
  exit_code         = 1
  message           = "Only eu-west-1 region is allowd"
}
module "raise_error_prod_account" {
  source            = "github.com/ulfox/terraform-generic-exception.git?ref=v0.0.1"
  condition         = [data.aws_caller_identity.current.account_id, "!=", "<someAccountID>"]
  exit_code         = 1
  message           = "Error, you are using production account"
}

resource "aws_instance" "bastion" {
  ami                         = local.bastion_ami_id
  instance_type               = var.bastion_instance_type
  key_name                    = var.bastion_ssh_keypair_name
  subnet_id                   = var.bastion_subnet_id
  vpc_security_group_ids      = local.bastion_vpc_security_group_ids
  associate_public_ip_address = local.bastion_set_public_ip
  availability_zone           = var.bastion_availability_zone
  ...
  depends_on = [
    module.raise_error_region,
    module.raise_error_prod_account,
  ]
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| condition | The condition | `list(string)` | `null` | no |
| exit\_code | The exit code | `string` | `null` | no |
| message | The exit message | `string` | `null` | no |
| shell\_condition | The shell condition | `string` | `null` | no |

## Outputs

No output.

