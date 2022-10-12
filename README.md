# terraform-aws-eks

[![build](https://img.shields.io/github/workflow/status/nalbam/terraform-aws-eks/build?label=build&style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks/actions/workflows/push.yaml)
[![release](https://img.shields.io/github/v/release/nalbam/terraform-aws-eks?style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks/releases)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1 |
| aws | >= 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.1.0 |
| kubernetes | n/a |
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addons\_irsa\_name | n/a | `map(string)` | `{}` | no |
| addons\_version | n/a | `map(string)` | `{}` | no |
| apply\_aws\_auth | n/a | `bool` | `false` | no |
| cluster\_log\_types | n/a | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| cluster\_name | n/a | `string` | n/a | yes |
| endpoint\_private\_access | n/a | `bool` | `true` | no |
| endpoint\_public\_access | n/a | `bool` | `false` | no |
| iam\_group | n/a | `string` | `""` | no |
| iam\_roles | n/a | `list(any)` | `[]` | no |
| ip\_family | n/a | `string` | `"ipv4"` | no |
| kubernetes\_version | n/a | `string` | `"1.22"` | no |
| masters | n/a | `list(string)` | `[]` | no |
| retention\_in\_days | n/a | `number` | `7` | no |
| save\_aws\_auth | n/a | `bool` | `false` | no |
| sslvpn\_name | n/a | `string` | `""` | no |
| ssm\_policy\_name | n/a | `string` | `""` | no |
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
