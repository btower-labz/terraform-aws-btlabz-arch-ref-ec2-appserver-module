# Terraform inputs and outputs.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amazon\_ec2\_role\_for\_aws\_code\_deploy | Enable AmazonEC2RoleforAWSCodeDeploy managed policy | `bool` | `true` | no |
| amazon\_ssm\_managed\_instance\_core | Enable AmazonSSMManagedInstanceCore managed policy | `bool` | `true` | no |
| ami | Workload AMI identifier | `string` | `""` | no |
| cloud\_watch\_agent\_server\_policy | Enable CloudWatchAgentServerPolicy managed policy | `bool` | `true` | no |
| config\_path | Configuration path for SSM and Secrets | `string` | `"/dev"` | no |
| dns\_name | R53 record name for the instance | `string` | `""` | no |
| dns\_record\_ttl | DNS recort TTL in seconds | `number` | `60` | no |
| key | EC2 instance EC2 key. | `string` | `""` | no |
| name | EC2 instance name. Will be used for object naming | `string` | `""` | no |
| security\_groups | EC2 instance security groups. | `list` | `[]` | no |
| size | EC2 instance type. | `string` | `"t3.small"` | no |
| subnet | EC2 instance subnet id | `string` | n/a | yes |
| tags | Additional tags. E.g. environment, backup tags etc. | `map` | `{}` | no |
| userdata | Override module's userdata | `string` | `""` | no |
| zone\_id | R53 zone identifier to create name records for the instance | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | The actual dns name of the record |
| fqdn | Fully qualified domain name of the instance |
| instance\_id | EC2 instance identifier |
| latest\_ami | The latest AMI |
| private\_ip | EC2 instance private ip address. |

