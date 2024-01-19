# aws_eks_addon

resource "aws_eks_addon" "addons" {
  for_each = var.addons_version

  addon_name    = each.key
  addon_version = lookup(var.addons_version, each.key, null)

  cluster_name = aws_eks_cluster.cluster.name

  resolve_conflicts_on_create = var.addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = var.addons_resolve_conflicts_on_update

  configuration_values = lookup(var.addons_configuration, each.key, "{}")

  service_account_role_arn = lookup(var.addons_irsa_role, each.key, null)

  depends_on = [aws_eks_cluster.cluster]
}
