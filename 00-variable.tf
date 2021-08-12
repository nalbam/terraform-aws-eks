# variable

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.21"
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

variable "endpoint_public_access" {
  type    = bool
  default = false
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

variable "efs_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "save_local_files" {
  type    = bool
  default = false
}
