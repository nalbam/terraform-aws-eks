# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: seoul-dev-demo-eks"
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

variable "subnet_azs" {
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
  type = list(object({
    rolearn = string
  }))
  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    group    = string
  }))
  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    group    = string
  }))
  default = []
}

variable "local_exec_interpreter" {
  description = "Command to run for local-exec resources. Must be a shell-style interpreter."
  type        = list(string)
  default     = ["/bin/sh", "-c"]
}
