# output

output "name" {
  value = module.eks.name
}

output "config" {
  value = module.eks.config
}

output "endpoint" {
  value = module.eks.endpoint
}
