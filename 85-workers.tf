# workers

module "workers" {
  # source = "../terraform-aws-eks-worker"
  source  = "nalbam/eks-worker/aws"
  version = "~> 3.0"

  for_each = {
    for w in var.workers :
    format("%s-%s-%s", w.name, try(w.subname, ""), try(w.vername, "")) => w
  }

  name    = each.value.name
  subname = try(each.value.subname, "")
  vername = try(each.value.vername, "")

  region     = var.region
  account_id = var.account_id

  cluster_name = var.cluster_name

  cluster_endpoint              = aws_eks_cluster.cluster.endpoint
  cluster_certificate_authority = data.aws_eks_cluster.cluster.certificate_authority.0.data

  ami_id          = try(each.value.ami_id, data.aws_ami.worker.id)
  role_name       = try(each.value.role_name, aws_iam_role.worker.name)
  security_groups = try(each.value.security_groups, [aws_security_group.worker.id])
  subnet_ids      = try(each.value.subnet_ids, var.subnet_ids)

  kubernetes_version = var.kubernetes_version

  key_name = try(each.value.key_name, null)

  enable_autoscale = try(each.value.enable_autoscale, true)
  enable_mixed     = try(each.value.enable_mixed, true)
  enable_taints    = try(each.value.enable_taints, false)

  on_demand_base = try(each.value.on_demand_base, 0)
  on_demand_rate = try(each.value.on_demand_rate, 0)

  mixed_instances = try(each.value.mixed_instances, ["t3.medium"])
  volume_type     = try(each.value.volume_type, "gp3")
  volume_size     = try(each.value.volume_size, "50")

  min = try(each.value.min, 1)
  max = try(each.value.max, 3)

  tags = local.tags

  depends_on = [
    aws_eks_cluster.cluster,
  ]
}

output "workers" {
  value = values(module.workers).*.worker_name
}
