region                              = "ap-southeast-1"
vpc_cidr                            = "10.0.0.0/16"
cidrsubnet_newbits                  = 8
bastion_instance_type               = "t2.micro"
bastion_key_name                    = "someKey"
whitelist_ssh_ip                    = ["0.0.0.0/0"]
whitelist_ip                        = ["0.0.0.0/0"]
access_log_bucket_acl               = "private"
force_destroy                       = true
rds_name_gitlab                     = "gitlabhq_production"
rds_username_gitlab                 = "rdsusername"
rds_password_gitlab                 = "rdspassword"
deletion_protection                 = false
skip_final_snapshot                 = true
gitlab_instance_type                = "c5.xlarge"
gitlab_key_name                     = "someKey"
load_balancer_bucket                = "gl-entry-dev"
gitlab_artifacts_bucket_name        = "gl-aws-artifacts-dev"
gitlab_external_diffs_bucket_name   = "gl-aws-external-diffs-dev"
gitlab_lfs_bucket_name              = "gl-aws-lfs-objects-dev"
gitlab_uploads_bucket_name          = "gl-aws-uploads-dev"
gitlab_packages_bucket_name         = "gl-aws-packages-dev"
gitlab_dependency_proxy_bucket_name = "gl-aws-dependency-proxy-dev"
gitlab_terraform_state_bucket_name  = "gl-aws-terraform-state-dev"
gitlab_aws_runner_cache             = "gl-aws-runner-cache-dev"
visibility                          = "private"
private_ip_gitlab                   = "10.0.0.4"
rds_name_gitaly                     = "gitalyhq_production"
rds_username_gitaly                 = "rdsusername"
rds_password_gitaly                 = "rdspassword"
gitaly_token                        = "someGitalyToken"
secret_token                        = "someSecretToken"
gitaly_config                       = "clustered" # "instance"
private_ips_gitaly                  = ["10.0.3.4", "10.0.4.4", "10.0.5.4"]
gitaly_key_name                     = "someKey"
private_ips_praefect                = ["10.0.3.5", "10.0.4.5", "10.0.5.5"]
praefect_key_name                   = "someKey"
praefect_sql_password               = "somePassword"
praefect_external_token             = "someToken"
praefect_instance_type              = "c5.xlarge"
grafana_password                    = "somePassword"
launch_configuration_name_prefix    = "gitlab-ha-launch-config"
autoscaling_group_name              = "gitlab-auto-scaling-group"