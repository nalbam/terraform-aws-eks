# worker iam role

resource "aws_iam_role" "route53" {
  name = "${var.name}-route53"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.name}-worker"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "route53" {
  role       = aws_iam_role.route53.name
  policy_arn = aws_iam_policy.route53.arn
}

resource "aws_iam_policy" "route53" {
  name        = "${module.worker.iam_role_name}-route53"
  description = "Route53 policy for cluster ${var.name}"
  policy      = data.aws_iam_policy_document.route53.json
  path        = "/"
}

data "aws_iam_policy_document" "route53" {
  statement {
    sid    = "Route53UpdateZones"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = ["arn:aws:route53:::zonename/*"]
  }

  statement {
    sid    = "Route53ListZones"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
    resources = ["*"]
  }
}
