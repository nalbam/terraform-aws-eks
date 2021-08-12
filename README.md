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
| local | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | n/a | `string` | n/a | yes |
| efs\_enabled | n/a | `bool` | `false` | no |
| endpoint\_private\_access | n/a | `bool` | `true` | no |
| endpoint\_public\_access | n/a | `bool` | `false` | no |
| iam\_group | n/a | `string` | `""` | no |
| iam\_roles | n/a | `list(any)` | `[]` | no |
| kubernetes\_version | n/a | `string` | `"1.21"` | no |
| masters | n/a | `list(string)` | `[]` | no |
| retention\_in\_days | n/a | `number` | `7` | no |
| save\_local\_files | n/a | `bool` | `false` | no |
| subnet\_ids | n/a | `list(string)` | n/a | yes |
| tags | n/a | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | n/a | yes |

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
| efs\_id | n/a |
| worker\_role\_arn | n/a |
| worker\_role\_name | n/a |
| worker\_security\_group | n/a |

<!--- END_TF_DOCS --->
