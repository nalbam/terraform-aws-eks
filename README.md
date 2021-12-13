# terraform-aws-eks

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.30.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.30.0 |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_log\_types | n/a | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| cluster\_name | n/a | `string` | n/a | yes |
| endpoint\_private\_access | n/a | `bool` | `true` | no |
| endpoint\_public\_access | n/a | `bool` | `false` | no |
| iam\_group | n/a | `string` | `""` | no |
| iam\_roles | n/a | `list(any)` | `[]` | no |
| kubernetes\_version | n/a | `string` | `"1.21"` | no |
| masters | n/a | `list(string)` | `[]` | no |
| retention\_in\_days | n/a | `number` | `7` | no |
| subnet\_ids | n/a | `list(string)` | n/a | yes |
| tags | n/a | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | n/a | yes |
| worker\_policies | n/a | `list(string)` | `[]` | no |
| worker\_source\_sgs | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_endpoint | n/a |
| cluster\_info | n/a |
| cluster\_name | n/a |
| cluster\_oidc\_arn | n/a |
| cluster\_oidc\_url | n/a |
| cluster\_role\_arn | n/a |
| cluster\_role\_name | n/a |
| cluster\_version | n/a |
| cluster\_vpc\_config | n/a |
| worker\_instance\_profile\_name | n/a |
| worker\_role\_arn | n/a |
| worker\_role\_name | n/a |
| worker\_security\_group | n/a |
| worker\_sqs\_id | n/a |

<!--- END_TF_DOCS --->
