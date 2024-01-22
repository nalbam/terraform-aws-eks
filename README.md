# terraform-aws-eks

[![build](https://img.shields.io/github/actions/workflow/status/nalbam/terraform-aws-eks/push.yml?branch=main&style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks/actions/workflows/push.yml)
[![release](https://img.shields.io/github/v/release/nalbam/terraform-aws-eks?style=for-the-badge&logo=github)](https://github.com/nalbam/terraform-aws-eks/releases)

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5 |
| aws | >= 5.1.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.1.0 |
| kubernetes | n/a |
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `string` | n/a | yes |
| addons\_configuration | n/a | `map(string)` | `{}` | no |
| addons\_irsa\_role | n/a | `map(string)` | `{}` | no |
| addons\_resolve\_conflicts\_on\_create | n/a | `string` | `"OVERWRITE"` | no |
| addons\_resolve\_conflicts\_on\_update | n/a | `string` | `"PRESERVE"` | no |
| addons\_version | n/a | `map(string)` | `{}` | no |
| allow\_cidr\_cluster | n/a | `list(string)` | `[]` | no |
| allow\_cidr\_internal | n/a | `list(string)` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| allow\_cidr\_public | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| allow\_prefix\_list\_ids | n/a | `list(string)` | `[]` | no |
| cluster\_log\_types | n/a | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| cluster\_name | n/a | `string` | n/a | yes |
| enable\_event | n/a | `bool` | `true` | no |
| endpoint\_private\_access | n/a | `bool` | `true` | no |
| endpoint\_public\_access | n/a | `bool` | `false` | no |
| iam\_group | n/a | `string` | `""` | no |
| iam\_roles | n/a | `list(any)` | `[]` | no |
| ip\_family | n/a | `string` | `"ipv4"` | no |
| kubernetes\_version | n/a | `string` | n/a | yes |
| masters | n/a | `list(string)` | `[]` | no |
| region | n/a | `string` | n/a | yes |
| retention\_in\_days | n/a | `number` | `30` | no |
| save\_aws\_auth | n/a | `bool` | `true` | no |
| save\_local\_files | n/a | `bool` | `false` | no |
| sslvpn\_name | n/a | `string` | `""` | no |
| ssm\_policy\_name | n/a | `string` | `""` | no |
| subnet\_ids | n/a | `list(string)` | n/a | yes |
| tags | n/a | `map(string)` | `{}` | no |
| vpc\_id | n/a | `string` | n/a | yes |
| worker\_ami\_arch | n/a | `string` | `"x86_64"` | no |
| worker\_ami\_keyword | n/a | `string` | `"*"` | no |
| worker\_policies | n/a | `list(string)` | `[]` | no |
| worker\_ports\_internal | n/a | `list(number)` | `[]` | no |
| worker\_ports\_public | n/a | `list(number)` | `[]` | no |
| worker\_source\_sgs | n/a | `list(string)` | `[]` | no |
| workers | n/a | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_certificate\_authority | n/a |
| cluster\_endpoint | n/a |
| cluster\_name | n/a |
| cluster\_oidc\_arn | n/a |
| cluster\_oidc\_url | n/a |
| cluster\_role\_arn | n/a |
| cluster\_role\_name | n/a |
| cluster\_version | n/a |
| cluster\_vpc\_config | n/a |
| worker\_ami\_id | n/a |
| worker\_instance\_profile\_name | n/a |
| worker\_role\_arn | n/a |
| worker\_role\_name | n/a |
| worker\_security\_group | n/a |
| worker\_sqs\_id | n/a |

<!--- END_TF_DOCS --->
