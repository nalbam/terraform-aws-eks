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

output "certificate_authority" {
  value = module.eks.certificate_authority
}

output "security_group_id" {
  value = module.eks.security_group_id
}

output "role_arn" {
  value = module.eks.role_arn
}

output "update-kubeconfig" {
  value = "aws eks update-kubeconfig --name ${module.eks.name} --alias ${module.eks.name}"
}
