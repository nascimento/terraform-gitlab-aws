# Gitaly Image Module

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_ingress\_security\_group\_id | The id of the security group allowed to communicate with Gitaly | `string` | `""` | no |
| gitaly\_key\_name | The key name of a key that has already been created that will be attached to the gitaly instance | `string` | n/a | yes |
| iam\_instance\_profile | IAM instance profile to associate with the Gitaly instance | `string` | n/a | yes |
| instance\_dns\_name | Domain that users will reach to access GitLab if using a public instance | `string` | n/a | yes |
| instance\_type | Instance type for the Gitaly instance | `string` | `"c5.xlarge"` | no |
| lb\_dns\_name | Domain that users will reach to access GitLab if using a load balancer | `string` | n/a | yes |
| praefect\_internal\_token | Token needed by to communicate with the Gitaly cluster | `string` | n/a | yes |
| private\_ips\_gitaly | Assigned private ips to gitaly instances | `list(string)` | n/a | yes |
| prometheus\_ingress\_security\_group\_id | The id of the security group allowed to hit prometheus endpoint | `string` | `""` | no |
| secret\_token | The token for authentication callbacks from GitLab Shell to the GitLab internal API | `string` | n/a | yes |
| ssh\_ingress\_security\_group\_id | The id of the security group allowed to ssh | `string` | `""` | no |
| subnet\_ids | Private subnet ids for clusters | `list(string)` | n/a | yes |
| visibility | Determines if the instance is private (behind a loadbalancer) or public (using its own dns) | `string` | `"private"` | no |
| vpc\_id | The id of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id | The id of the security group associated with the Gitaly instance |

