# Dev environment

Link for manual installation: [Installing GitLab on Amazon Web Services (AWS)](https://docs.gitlab.com/ee/install/aws/)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.28 |
| aws | >= 2.70.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_log\_bucket\_acl | The canned ACL to apply. Options are `private`, `public-read`, `public-read-write` among others | `string` | `"private"` | no |
| autoscaling\_group\_name | The name of the auto scaling group | `string` | `"gitlab-auto-scaling-group"` | no |
| bastion\_instance\_type | The Bastion instance type | `string` | `"t2.micro"` | no |
| bastion\_key\_name | The Bastion key name of a key that has already been created | `string` | n/a | yes |
| cidrsubnet\_newbits | Second argument to cidrsubnet function | `number` | `8` | no |
| deletion\_protection | Database cannot be deleted if set to true | `bool` | `false` | no |
| force\_destroy | Indicates that all objects should be deleted from the bucket so that it can be destroyed without error | `bool` | `true` | no |
| gitaly\_config | The configuration for gitaly. Can be clustered or a single instance | `string` | `"clustered"` | no |
| gitaly\_key\_name | The Gitaly key name of a key that has already been created | `string` | n/a | yes |
| gitaly\_token | The token authenticate gRPC requests to Gitaly. For praefect, it is used in praefect\_internal\_token | `string` | n/a | yes |
| gitlab\_artifacts\_bucket\_name | The artifact bucket's name | `string` | `"gl-aws-artifacts"` | no |
| gitlab\_aws\_runner\_cache | The Runner Cache bucket's name | `string` | `"gl-aws-runner-cache"` | no |
| gitlab\_dependency\_proxy\_bucket\_name | The dependency proxy bucket's name | `string` | `"gl-aws-dependency-proxy"` | no |
| gitlab\_external\_diffs\_bucket\_name | The external diffs bucket's name | `string` | `"gl-aws-external-diffs"` | no |
| gitlab\_instance\_type | The Gitlab instance type | `string` | `"c5.xlarge"` | no |
| gitlab\_key\_name | The GitLab key name of a key that has already been created | `string` | n/a | yes |
| gitlab\_lfs\_bucket\_name | The large file storage objects bucket's name | `string` | `"gl-aws-lfs-objects"` | no |
| gitlab\_packages\_bucket\_name | The packages bucket's name | `string` | `"gl-aws-packages"` | no |
| gitlab\_terraform\_state\_bucket\_name | The terraform state bucket's name | `string` | `"gl-aws-terraform-state"` | no |
| gitlab\_uploads\_bucket\_name | The user uploads bucket's name | `string` | `"gl-aws-uploads"` | no |
| grafana\_password | Password to access Grafana | `string` | n/a | yes |
| launch\_configuration\_name\_prefix | Creates a unique name beginning with the specified prefix. | `string` | `"gitlab-ha-launch-config"` | no |
| load\_balancer\_bucket | Bucket for the load balancer | `string` | `"gl-entry"` | no |
| praefect\_external\_token | Token needed by clients outside the cluster (like GitLab Shell) to communicate with the Praefect cluster | `string` | n/a | yes |
| praefect\_instance\_type | Instance type for the praefect instance | `string` | `"c5.xlarge"` | no |
| praefect\_key\_name | The key name of a key that has already been created that will be attached to the praefect instance | `string` | n/a | yes |
| praefect\_sql\_password | Password for the praefect db user | `string` | n/a | yes |
| private\_ip\_gitlab | The private ip of the GitLab instance. Instance removed in HA | `string` | n/a | yes |
| private\_ips\_gitaly | Assigned private ips to gitaly instances | `list(string)` | n/a | yes |
| private\_ips\_praefect | Assigned private ips to praefect instances | `list(string)` | n/a | yes |
| rds\_name\_gitaly | The name of the database to create when the DB instance is created for Gitaly cluster | `string` | `"gitalyhq_production"` | no |
| rds\_name\_gitlab | The name of the database to create when the DB instance is created for GitLab instance | `string` | `"gitlabhq_production"` | no |
| rds\_password\_gitaly | Password for the master DB user for Gitaly cluster | `string` | n/a | yes |
| rds\_password\_gitlab | Password for the master DB user for GitLab instance | `string` | n/a | yes |
| rds\_username\_gitaly | Username for the master DB user for Gitaly cluster | `string` | n/a | yes |
| rds\_username\_gitlab | Username for the master DB user for GitLab instance | `string` | n/a | yes |
| region | The region to deploy the resources in | `string` | `"ap-southeast-1"` | no |
| secret\_token | The token for authentication callbacks from GitLab Shell to the GitLab internal API | `string` | n/a | yes |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted | `bool` | `true` | no |
| visibility | Determines if the instance is private (behind a loadbalancer) or public (using its own dns) | `string` | `"private"` | no |
| vpc\_cidr | VPC Cidr Range | `string` | `"10.0.0.0/16"` | no |
| whitelist\_ip | The list of IPs that can reach the load balancer via HTTP or HTTPs | `list(string)` | n/a | yes |
| whitelist\_ssh\_ip | The list of IPs that can SSH into the Bastion | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_ip | The elastic ip associated with the bastion instance |
| eks\_endpoint | The endpoint for your Kubernetes API server |
| gitlab\_instance\_public\_dns | The public DNS of the instance |
| gitlab\_loadbalancer\_dns\_name | The endpoint of the GitLab load balancer |

