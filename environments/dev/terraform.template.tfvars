region                              = "ap-southeast-1"
vpc_cidr                            = "10.0.0.0/16"
cidrsubnet_newbits                  = 8
bastion_instance_type               = "t2.micro"
bastion_key_name                    = "someKey"
whitelist_ssh_ip                    = ["0.0.0.0/0"]
whitelist_ip                        = ["0.0.0.0/0"]
access_log_bucket_acl               = "private"
force_destroy                       = true
rds_username                        = "rdsusername"
rds_password                        = "rdspassword"
deletion_protection                 = false
skip_final_snapshot                 = true
gitlab_instance_type                = "c5.xlarge"
gitlab_key_name                     = "someKey"
gitlab_artifacts_bucket_name        = "gl-aws-artifacts"
gitlab_external_diffs_bucket_name   = "gl-aws-external-diffs"
gitlab_lfs_bucket_name              = "gl-aws-lfs-objects"
gitlab_uploads_bucket_name          = "gl-aws-uploads"
gitlab_packages_bucket_name         = "gl-aws-packages"
gitlab_dependency_proxy_bucket_name = "gl-aws-dependency-proxy"
gitlab_terraform_state_bucket_name  = "gl-aws-terraform-state"
visibility                          = "private"