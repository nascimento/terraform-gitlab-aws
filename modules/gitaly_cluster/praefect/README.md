# Praefect Module

## Issues and fixes

<b>Issue 1: Instances show up as unhealthy even with healthcheck configured on port 2305</b>

Fix: Configure praefect instance to allow ingress from the VPC IP which allows the NLB to reach the instances. This also allows us to remove the gitaly security group id from port 2305 ingress since its instances are part of the vpc\_ip range specified.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_ingress\_security\_group\_id | The id of the security group allowed to communicate with Praefect | `string` | `""` | no |
| iam\_instance\_profile | IAM instance profile to associate with the Praefect instance | `string` | n/a | yes |
| instance\_type | Instance type for the praefect instance | `string` | `"c5.xlarge"` | no |
| praefect\_external\_token | Token needed by clients outside the cluster (like GitLab Shell) to communicate with the Praefect cluster | `string` | n/a | yes |
| praefect\_internal\_token | Token needed by to communicate with the Gitaly cluster | `string` | n/a | yes |
| praefect\_key\_name | The key name of a key that has already been created that will be attached to the praefect instance | `string` | n/a | yes |
| praefect\_sql\_password | Password for the praefect db user | `string` | n/a | yes |
| private\_ips\_gitaly | Assigned private ips to gitaly instances | `list(string)` | n/a | yes |
| private\_ips\_praefect | Assigned private ips to praefect instances | `list(string)` | n/a | yes |
| prometheus\_ingress\_security\_group\_id | The id of the security group allowed to hit prometheus endpoint | `string` | `""` | no |
| rds\_address | The hostname of the RDS instance which does not have `port` | `string` | n/a | yes |
| rds\_name | The name of the database to create when the DB instance is created. | `string` | `"gitalyhq_production"` | no |
| rds\_password | Password for the master DB user | `string` | n/a | yes |
| rds\_username | Username for the master DB user | `string` | n/a | yes |
| ssh\_ingress\_security\_group\_id | The id of the security group allowed to ssh | `string` | `""` | no |
| subnet\_ids | Private subnet ids for clusters | `list(string)` | n/a | yes |
| vpc\_cidr | VPC Cidr Range used to allow Praefect NLB healthcheck to reach instances | `string` | `"10.0.0.0/16"` | no |
| vpc\_id | The id of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| prafect\_loadbalancer\_dns\_name | The dns name associated with the Praefect loadbalancer |
| security\_group\_id | The id of the security group associated with the Praefect instance |

