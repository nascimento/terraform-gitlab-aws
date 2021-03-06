# Gitlab Image Module

## Issues and fixes

<b>Issue 1: Finding the `owner` of the image</b>

This [link](https://www.terraform.io/docs/configuration/data-sources.html) mentions that the `owners` tag is compulsory. To find which is the correct value, use the console to get the ami-id and then run the following command. In this case I use the ami-id of a gitlab AMI. The first command is Gitlab EE 12.9.2.The second command is Gitlab EE 13.1.4.

```bash
aws ec2 describe-images --image-id ami-056524c0a8b3d1d92
aws ec2 describe-images --image-id ami-099fef660cf8719e1
```

<b>Issue 2: Configuring storage requires Gitlab 13.2 but no AMI exists</b>

Begin installation from source - source only reaches to 13.1.4. Hence instead of Consolidated form, we use Storage-specific form

<b>Issue 3: `sed` command was giving the correct output but the file was unchanged</b>

Fix: [Link](https://stackoverflow.com/questions/14387163/linux-sed-command-does-not-change-the-target-file). Just add `-i` flag

Also there is an online editor that helps test commands at this [link](https://sed.js.org/)

Tip: When dealing with URLs and we need to identify the `/`, we can use `+` as the separator

<b>Issue 4: Passing paramaters into a bash file</b>

Refer to this [link about passing](https://github.com/terraform-providers/terraform-provider-aws/issues/5498)

The [Terraform documentation](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) shows how to pass and receive parameters

<b>Issue 5: `Error: InvalidAMIName.Duplicate: AMI name GitLab-Source is already in use by AMI ami-<id>`</b>

Reproduing the error: When I run the terraform script the second name, since the image name of `GitLab-Source` already exists, it throws an error

Fix:
* Generate a random 8 length byte that will be appended to the name to have high confidence that the name will not be duplicated. Here is the [link](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id)
* Add `uuid()` to introduce randomness on each run. [Link](https://www.reddit.com/r/Terraform/comments/abtsq3/how_to_generate_a_new_random_string_everytime_i/)
* Terraform preserves the random value each run to maintain state. [Link](https://registry.terraform.io/providers/hashicorp/random/latest/docs)

## Additional details

<b>Detail 1: Manual step needed to get the private IP of the Gitaly instance</b>

Since there is a cicrcular dependency, we have to manually add in the gitaly private IP. This is the helper command. Remember to change the IP

```bash
sed -i "s/gitaly_internal_ip/10.0.3.50/" gitlab.rb
```

<b>Detail 2: Install an SSM agent</b>

Install an ssm agent to ssh directly. The image is based on Ubuntu16.04.1 LTS Xenial but I use the install for the Ubuntu16.04 (deb) as this was the one that worked with bash. [Installation link](https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-ubuntu.html#agent-install-ubuntu-tabs)

For the Grafana setup, make sure to reset the password internally. Somehow this step can't be automated. Access Grafana at `https://<dns_name>/-/grafana`

```bash
gitlab-ctl set-grafana-password
${grafana_password}
${grafana_password}
```

<b>Detail 3: Checking GitLab version</b>

```bash
sudo gitlab-rake gitlab:env:info
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_name | Domain that users will reach to access GitLab | `string` | n/a | yes |
| gitaly\_config | The configuration for gitaly. Can be clustered or a single instance | `string` | `"clustered"` | no |
| gitaly\_token | The token authenticate gRPC requests to Gitaly | `string` | n/a | yes |
| gitlab\_artifacts\_bucket\_name | The artifact bucket's name | `string` | `"gl-aws-artifacts"` | no |
| gitlab\_dependency\_proxy\_bucket\_name | The dependency proxy bucket's name | `string` | `"gl-aws-dependency-proxy"` | no |
| gitlab\_external\_diffs\_bucket\_name | The external diffs bucket's name | `string` | `"gl-aws-external-diffs"` | no |
| gitlab\_key\_name | The key name of a key that has already been created that will be attached to the GitLab instance | `string` | n/a | yes |
| gitlab\_lfs\_bucket\_name | The large file storage objects bucket's name | `string` | `"gl-aws-lfs-objects"` | no |
| gitlab\_packages\_bucket\_name | The packages bucket's name | `string` | `"gl-aws-packages"` | no |
| gitlab\_terraform\_state\_bucket\_name | The terraform state bucket's name | `string` | `"gl-aws-terraform-state"` | no |
| gitlab\_uploads\_bucket\_name | The user uploads bucket's name | `string` | `"gl-aws-uploads"` | no |
| grafana\_password | Password to access Grafana | `string` | n/a | yes |
| http\_ingress\_security\_group\_ids | The ids of the security groups allowed to hit HTTP endpoint | `list(string)` | n/a | yes |
| instance\_type | Instance type for the GitLab instance | `string` | `"c5.xlarge"` | no |
| praefect\_external\_token | Token needed by clients outside the cluster (like GitLab Shell) to communicate with the Praefect cluster | `string` | `""` | no |
| prafect\_loadbalancer\_dns\_name | The dns name associated with the Praefect loadbalancer | `string` | `""` | no |
| private\_ip\_gitlab | The private ip of the GitLab instance. Instance removed in HA | `string` | n/a | yes |
| private\_ips\_gitaly | Assigned private ips to gitaly instances | `list(string)` | n/a | yes |
| private\_ips\_praefect | Assigned private ips to praefect instances | `list(string)` | <pre>[<br>  "",<br>  "",<br>  ""<br>]</pre> | no |
| prometheus\_ingress\_security\_group\_ids | The ids of the security groups allowed to hit prometheus endpoint | `list(string)` | `[]` | no |
| rds\_address | The hostname of the RDS instance which does not have `port` | `string` | n/a | yes |
| rds\_name | The name of the database to create when the DB instance is created. | `string` | `"gitlabhq_production"` | no |
| rds\_password | Password for the master DB user | `string` | n/a | yes |
| rds\_username | Username for the master DB user | `string` | n/a | yes |
| redis\_address | The address of the endpoint for the primary node in the elasticache replication group, if the cluster mode is disabled. | `string` | n/a | yes |
| region | The region to deploy the resources in | `string` | n/a | yes |
| secret\_token | The token for authentication callbacks from GitLab Shell to the GitLab internal API | `string` | n/a | yes |
| ssh\_ingress\_security\_group\_ids | The ids of the security groups allowed to ssh | `list(string)` | n/a | yes |
| subnet\_id | Private or public subnet id depending on requirements | `string` | n/a | yes |
| visibility | Determines if the instance is private (behind a loadbalancer) or public (using its own dns) | `string` | `"private"` | no |
| vpc\_id | The id of the VPC | `string` | n/a | yes |
| whitelist\_ip | Whitelist of IPs that can reach the instance via HTTP or HTTPs | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_instance\_profile | IAM instance profile attached to the GitLab instance |
| image\_id | The id of the created GitLab AMI |
| public\_dns | The public DNS of the instance |
| security\_group\_id | The id of the security group associated with the GitLab instance |

