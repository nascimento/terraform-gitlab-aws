# Bastion Module

Creates a Bastion Instance with an Elastic IP in an Auto Scaling Group across all the provided public subnets of a VPC.

Best practices for Bastion Hosts. [AWS documentation: Bastion architecture](https://docs.aws.amazon.com/quickstart/latest/linux-bastion/architecture.html)

Implementation for an EIP with ASG can be tricky and I found this article [medium:Resilient AWS instances using Auto Scaling Groups and Terraform](https://medium.com/@tech_phil/resilient-aws-instances-using-auto-scaling-groups-and-terraform-c7bbe43de521) useful. I had to modify the ami part and the bash script (There was also an additional line in the comments that was useful).

## Issues and fixes

<b>Issue 1: Cannot use the AMI from the Launch Instance page</b>

Fix: I used the [AWS Quick Start document about bastion hosts](https://docs.aws.amazon.com/quickstart/latest/linux-bastion/step2.html), under "Option 2: Parameters for deploying Linux bastion hosts into an existing VPC" to retrieve the correct AMI from the provided template

<b>Issue 2: Finding out who is the `owner` of the ami since I did not want to hardcode an AMI but search it by its name</b>

This [link](https://www.terraform.io/docs/configuration/data-sources.html) mentions that the `owners` tag is compulsory. To find which is the correct value, use the console to get the ami-id and then run the following command. In this case I use the ami-id of a Amazon Linux2 AMI

```bash
aws ec2 describe-images --image-id ami-0ec225b5e01ccb706
```

<b>Issue 3: Configuring the region in the bash script</b>

Running `aws configure` forced one to type "enter" for the Access Key ID and Secret Access Key (even though I was attaching an IAM role). The bash script couldn't handle that. I needed a way to just set the region. Refer to the `aws configure set` command and leave out the `--profile`. Refer to [aws docs: Configuration and credential file settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

## Additional details

Read [Getting credentials from EC2 instance metadata](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-metadata.html) for a better understanding of how IAM roles work with EC2 instances

In this module I assume the user already has a key in AWS. However, if the user intends to create the key, the following block can be added instead.
```
resource "aws_key_pair" "bastion" {
  key_name   = var.bastion_key_name
  public_key = file(var.bastion_public_key)
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_key\_name | The key name of a key that has already been created that will be attached to the Bastion instance | `string` | n/a | yes |
| instance\_type | The Bastion instance type | `string` | `"t2.micro"` | no |
| region | The region to deploy the resources in | `string` | n/a | yes |
| subnet\_ids | The list of public subnet ids | `list(string)` | n/a | yes |
| vpc\_id | The id of the VPC | `string` | n/a | yes |
| whitelist\_ssh\_ip | The list of IPs that can SSH into the Bastion | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| public\_ip | The elastic ip associated with the Bastion instance |

