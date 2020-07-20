region                = "ap-southeast-1"
vpc_cidr              = "10.0.0.0/16"
cidrsubnet_newbits    = 8
bastion_instance_type = "t2.micro"
bastion_key_name      = "someKey"
whitelist_ssh_ip      = ["0.0.0.0/0"]
whitelist_ip          = ["0.0.0.0/0"]
access_log_bucket_acl = "private"
force_destroy         = true
rds_username          = "rdsusername"
rds_password          = "rdspassword"
deletion_protection   = false
skip_final_snapshot   = true