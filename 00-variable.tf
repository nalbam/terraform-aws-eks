# variable

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.22"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "ip_family" {
  type    = string
  default = "ipv4"
}

variable "endpoint_public_access" {
  type    = bool
  default = false
}

variable "cluster_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "retention_in_days" {
  type    = number
  default = 7
}

variable "iam_group" {
  type    = string
  default = ""
}

variable "iam_roles" {
  type    = list(any)
  default = []
}

variable "masters" {
  type    = list(string)
  default = []
}

variable "sslvpn_name" {
  type    = string
  default = ""
}

variable "worker_policies" {
  type    = list(string)
  default = []
}

variable "worker_source_sgs" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "addons_version" {
  type    = map(string)
  default = {
    # "kube-proxy" : "v1.22.6-eksbuild.1"
    # "coredns" : "v1.8.7-eksbuild.1"
    # "vpc-cni" : "v1.10.3-eksbuild.1"
  }
}

variable "addons_irsa_role" {
  type    = map(string)
  default = {
    # "vpc-cni" : "arn:aws:iam::123456789012:role/irsa--aws-node"
  }
}
