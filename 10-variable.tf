# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: dev-demo-eks"
}

variable "kubernetes_version" {
  default = "1.14"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "allow_ip_address" {
  description = "List of IP Address to permit access"
  type        = list(string)
  default     = []
}

variable "workers" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = list(string)
  default     = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "enable_irsa" {
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = false
}

variable "eks_oidc_thumbprint" {
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  type        = string
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "save_local_file" {
  type    = bool
  default = false
}
