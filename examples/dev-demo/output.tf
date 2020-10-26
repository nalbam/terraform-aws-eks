# output

output "id" {
  value = module.eks.id
}

output "name" {
  value = module.eks.name
}

output "version" {
  value = module.eks.version
}

output "endpoint" {
  value = module.eks.endpoint
}

# output "certificate_authority" {
#   value = module.eks.certificate_authority
# }

output "worker_role_arn" {
  value = module.eks.worker_role_arn
}

output "worker_security_groups" {
  value = module.eks.worker_security_groups
}

output "update-kubeconfig" {
  value = "aws eks update-kubeconfig --name ${module.eks.name} --alias ${module.eks.name}"
}
