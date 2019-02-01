# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "city" {
  description = "City Name of the cluster, e.g: VIRGINIA"
}

variable "stage" {
  description = "Stage Name of the cluster, e.g: DEV"
}

variable "name" {
  description = "Name of the cluster, e.g: DEMO"
}

variable "suffix" {
  description = "Name of the cluster, e.g: EKS"
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "subnet_ids" {
  description = "List of Subnet Ids"
  type        = "list"
  default     = []
}

variable "launch_configuration_enable" {
  default = true
}

variable "launch_template_enable" {
  default = false
}

variable instance_type {
  default = "m4.large"
}

variable min {
  default = "2"
}

variable max {
  default = "5"
}

variable key_name {
  default = ""
}

variable "key_path" {
  default = ""
}

variable "allow_ip_address" {
  description = "List of IP Address to permit access"
  type        = "list"
  default     = ["*"]
}
