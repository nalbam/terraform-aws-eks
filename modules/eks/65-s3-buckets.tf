# buckets

resource "aws_s3_bucket" "buckets" {
  count  = "${length(var.buckets)}"
  bucket = "${local.lower_name}-${var.buckets[count.index]}"
  acl    = "private"

  tags = "${
    map(
      "Name", "${local.lower_name}-${var.buckets[count.index]}",
      "KubernetesCluster", "${local.lower_name}",
      "kubernetes.io/cluster/${local.lower_name}", "owned",
    )
  }"
}

resource "aws_iam_role_policy_attachment" "worker-buckets" {
  count      = "${length(var.buckets)}"
  role       = "${aws_iam_role.worker.name}"
  policy_arn = "${aws_iam_policy.worker-buckets.*.arn[count.index]}"
}

resource "aws_iam_policy" "worker-buckets" {
  count       = "${length(var.buckets)}"
  name        = "${aws_iam_role.worker.name}-S3-${upper(var.buckets[count.index])}"
  description = "S3 bucket policy for cluster ${local.lower_name}"
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
        "arn:aws:s3:::${local.lower_name}-${var.buckets[count.index]}",
        "arn:aws:s3:::${local.lower_name}-${var.buckets[count.index]}/*"
      ]
    }
  ]
}
EOF
}
