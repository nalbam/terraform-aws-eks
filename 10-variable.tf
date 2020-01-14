# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "config" {
  type = object({
    name               = string
    vpc_id             = string
    subnet_ids         = list(string)
    kubernetes_version = string
    allow_ip_address   = list(string)
    workers            = list(string)
    map_roles = list(object({
      rolearn  = string
      username = string
      groups   = list(string)
    }))
    map_users = list(object({
      userarn  = string
      username = string
      groups   = list(string)
    }))
  })
  # default = {
  #   kubernetes_version = "1.14"
  # }
}

variable "enable_irsa" {
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = false
}

variable "eks_oidc_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
