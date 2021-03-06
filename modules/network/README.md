# Network Module

* Creates a VPC with all subnets having internet access. It has the following:
  * VPC
  * Public and Private subnets in each AZ within a specified region.
  * Internet Gateway
  * NatGateway in each public subnet
  * Route tables

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | Availability zones to deploy the subnets in | `list(string)` | n/a | yes |
| cidrsubnet\_newbits | Second argument to cidrsubnet function | `number` | `8` | no |
| region | The region to deploy the resources in | `string` | n/a | yes |
| vpc\_cidr | VPC Cidr Range | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_subnet\_private\_ids | A list of all private subnet ids |
| this\_subnet\_public\_ids | A list of all public subnet ids |
| vpc\_id | The id of the created VPC |
| vpce\_id | Id of the VPCE |

