# terraform-aws-eks

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_ip\_address | List of IP Address to permit access. | `list(string)` | `[]` | no |
| cluster\_log\_kms\_key\_id | If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html) | `string` | `""` | no |
| cluster\_log\_retention\_in\_days | Number of days to retain log events. Default retention - 90 days. | `number` | `14` | no |
| cluster\_log\_types | A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| efs\_enabled | EFS 스토리지를 생성 여부를 선택 합니다. | `bool` | `false` | no |
| eks\_oidc\_thumbprint | Thumbprint of Root CA for EKS OIDC, Valid until 2037 | `string` | `"9e99a48a9960b14926bb7f3b02e22da2b0ab7280"` | no |
| endpoint\_private\_access | n/a | `bool` | `true` | no |
| endpoint\_public\_access | n/a | `bool` | `false` | no |
| irsa\_enabled | Whether to create OpenID Connect Provider for EKS to enable IRSA | `bool` | `true` | no |
| kubernetes\_version | n/a | `string` | `"1.18"` | no |
| name | Name of the cluster, e.g: dev-demo-eks | `any` | n/a | yes |
| region | The region to deploy the cluster in, e.g: us-east-1 | `any` | n/a | yes |
| roles | Additional IAM roles to add to the aws-auth configmap. | `list` | `[]` | no |
| save\_local\_file | n/a | `bool` | `false` | no |
| subnet\_ids | n/a | `list(string)` | `[]` | no |
| tags | n/a | `map(string)` | `{}` | no |
| users | Additional IAM users to add to the aws-auth configmap. | `list` | `[]` | no |
| vpc\_id | n/a | `string` | `""` | no |
| workers | Additional worker node roles to add to the aws-auth configmap. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_role\_arn | n/a |
| cluster\_role\_name | n/a |
| cluster\_security\_groups | n/a |
| efs\_id | n/a |
| endpoint | n/a |
| id | n/a |
| name | n/a |
| oidc\_arn | n/a |
| oidc\_issuer | n/a |
| version | n/a |
| vpc\_config | n/a |
| worker\_ami\_id | n/a |
| worker\_role\_arn | n/a |
| worker\_role\_name | n/a |
| worker\_security\_groups | n/a |

<!--- END_TF_DOCS --->
