# buckets

resource "aws_s3_bucket" "buckets" {
  count  = length(var.buckets)
  bucket = "${local.full_name}-${var.buckets[count.index]}"
  acl    = "private"

  tags = {
    "Name"                                      = "${local.full_name}-${var.buckets[count.index]}"
    "KubernetesCluster"                         = local.full_name
    "kubernetes.io/cluster/${local.full_name}" = "owned"
  }
}

resource "aws_iam_role_policy_attachment" "worker-buckets" {
  count      = length(var.buckets)
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.worker-buckets[count.index].arn
}

resource "aws_iam_policy" "worker-buckets" {
  count       = length(var.buckets)
  name        = "${aws_iam_role.worker.name}-s3-${var.buckets[count.index]}"
  description = "S3 bucket policy for cluster ${local.full_name}"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${local.full_name}-${var.buckets[count.index]}",
        "arn:aws:s3:::${local.full_name}-${var.buckets[count.index]}/*"
      ]
    }
  ]
}
EOF

}
