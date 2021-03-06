# Autoscaling group module

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autoscaling\_group\_name | The name of the auto scaling group | `string` | `"gitlab-auto-scaling-group"` | no |
| iam\_instance\_profile | IAM instance profile to associate with the GitLab instance | `string` | n/a | yes |
| image\_id | The AMI ID of the GitLab image | `string` | n/a | yes |
| instance\_type | Instance type for the GitLab instance | `string` | `"c5.xlarge"` | no |
| launch\_configuration\_name\_prefix | Creates a unique name beginning with the specified prefix. | `string` | `"gitlab-ha-launch-config"` | no |
| security\_groups | The list of security group ids associated with the GitLab instance | `list(string)` | n/a | yes |
| subnet\_ids | The list of private subnet ids | `list(string)` | n/a | yes |
| target\_group\_arns | A set of aws\_alb\_target\_group ARNs, for use with Application or Network Load Balancing. | `list(string)` | n/a | yes |

## Outputs

No output.

