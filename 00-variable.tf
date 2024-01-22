# variable

variable "region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
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
  default = 30
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
  default = "" # ALLOW SSLVPN CIDR-s
}

variable "ssm_policy_name" {
  type    = string
  default = "" # session-manager-access-policy
}

variable "worker_ami_arch" {
  type    = string
  default = "x86_64" # arm64
}

variable "worker_ami_keyword" {
  type    = string
  default = "*"
}

variable "worker_policies" {
  type    = list(string)
  default = []
}

variable "worker_source_sgs" {
  type    = list(string)
  default = []
}

variable "worker_ports_internal" {
  type    = list(number)
  default = []
}

variable "worker_ports_public" {
  type    = list(number)
  default = []
}

variable "allow_prefix_list_ids" {
  type    = list(string)
  default = []
}

variable "allow_cidr_cluster" {
  type    = list(string)
  default = []
}

variable "allow_cidr_internal" {
  type    = list(string)
  default = ["10.0.0.0/8"]
}

variable "allow_cidr_public" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "addons_version" {
  type = map(string)
  default = {
    # "coredns" : "v1.xx.x-eksbuild.1"
    # "kube-proxy" : "v1.xx.x-eksbuild.1"
    # "vpc-cni" : "v1.xx.x-eksbuild.1"
  }
}

variable "addons_resolve_conflicts_on_create" {
  type    = string
  default = "OVERWRITE" # NONE and OVERWRITE.
}

variable "addons_resolve_conflicts_on_update" {
  type    = string
  default = "PRESERVE" # NONE, OVERWRITE and PRESERVE.
}

variable "addons_configuration" {
  type = map(string)
  default = {
    # "coredns" : "{}"
    # "kube-proxy" : "{}"
    # "vpc-cni" : "{}"
  }
}

variable "addons_irsa_role" {
  type = map(string)
  default = {
    # "vpc-cni" : "arn:aws:iam::123456789012:role/irsa--aws-node"
  }
}

variable "save_local_files" {
  type    = bool
  default = false
}

variable "save_aws_auth" {
  type    = bool
  default = true
}

variable "enable_event" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "workers" {
  default = {
    # "workers" : {}
  }
}
