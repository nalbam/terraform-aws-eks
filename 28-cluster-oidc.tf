# https://github.com/terraform-providers/terraform-provider-aws/issues/10104
# ./kubergrunt eks oidc-thumbprint --issuer-url https://oidc.eks.ap-northeast-2.amazonaws.com/id/2D9B0DEC224511C56CA681308AAC23E4

resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  ]
  url = aws_eks_cluster.cluster.identity.0.oidc.0.issuer

  tags = merge(
    local.tags,
    {
      "Name" = local.cluster_name
    },
  )
}
