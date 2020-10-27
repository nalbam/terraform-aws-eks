# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "name" {
  description = "Name of the cluster, e.g: dev-demo-eks"
}

variable "kubernetes_version" {
  default = "1.18"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "endpoint_public_access" {
  type    = bool
  default = false
}

variable "cluster_log_types" {
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  # api, audit, authenticator, controllerManager, scheduler
}

variable "cluster_log_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
  default     = ""
}

variable "cluster_log_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 90 days."
  type        = number
  default     = 14
}

variable "allow_ip_address" {
  description = "List of IP Address to permit access."
  type        = list(string)
  default     = []
}

variable "workers" {
  description = "Additional worker node roles to add to the aws-auth configmap."
  type        = list(string)
  default     = []
}

variable "roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  # type        = list(map)
  default = []
}

variable "users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  # type        = list(map)
  default = []
}

variable "eks_oidc_thumbprint" {
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  type        = string
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "irsa_enabled" {
  description = "Whether to create OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "efs_enabled" {
  description = "EFS 스토리지를 생성 여부를 선택 합니다."
  type        = bool
  default     = false
}

variable "save_local_file" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
