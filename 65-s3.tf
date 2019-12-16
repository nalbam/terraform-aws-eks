# s3

resource "aws_s3_bucket" "buckets" {
  count  = length(var.buckets)
  bucket = "${var.name}-${var.buckets[count.index]}"
  acl    = "private"

  tags = {
    "Name"                              = "${var.name}-${var.buckets[count.index]}"
    "KubernetesCluster"                 = var.name
    "kubernetes.io/cluster/${var.name}" = "owned"
  }
}

resource "aws_iam_role" "worker-buckets" {
  count = length(var.buckets)
  name  = "${var.name}-${var.buckets[count.index]}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${local.account_id}:role/${var.name}-worker"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "worker-buckets" {
  count      = length(var.buckets)
  role       = aws_iam_role.worker-buckets[count.index].name
  policy_arn = aws_iam_policy.worker-buckets[count.index].arn
}

resource "aws_iam_policy" "worker-buckets" {
  count       = length(var.buckets)
  name        = "${var.name}-${var.buckets[count.index]}"
  description = "S3 bucket policy for ${var.name}"
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
        "arn:aws:s3:::${var.name}-${var.buckets[count.index]}",
        "arn:aws:s3:::${var.name}-${var.buckets[count.index]}/*"
      ]
    }
  ]
}
EOF

}
