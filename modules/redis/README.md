# Redis Module

Creates a Redis Instance with multi-az and automatic failover

## Issues and fixes

<b>Issue 1: Redis is not deployed as multi-az</b>

This is a feature that has not been added to Terraform yet. Updates can be found [here](https://github.com/terraform-providers/terraform-provider-aws/issues/13706)

## Additional details

If we want to create a single instance of Redis, use the following block

```
resource "aws_elasticache_cluster" "gitlab-redis" {
  cluster_id           = "gitlab-redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  parameter_group_name = var.parameter_group_name
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = [aws_security_group.this.id]
  engine_version       = "5.0.6"
  port                 = 6379
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | Availability zones to deploy the subnets in | `list(string)` | n/a | yes |
| engine\_version | Version number of the cache engine to be used | `string` | `"5.0.6"` | no |
| ingress\_security\_group\_ids | The list security group id of the security group that is allowed ingress | `list(string)` | n/a | yes |
| node\_type | The compute and memory capacity of the nodes | `string` | `"cache.t3.medium"` | no |
| parameter\_group\_name | Name of the parameter group to associate with this cache cluster | `string` | `"default.redis5.0"` | no |
| replication\_group\_id | The replication group identifier | `string` | `"gitlab-redis"` | no |
| subnet\_ids | The list of public subnet ids | `list(string)` | n/a | yes |
| vpc\_id | The id of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| primary\_address | The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled. |

