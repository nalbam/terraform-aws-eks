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
        "Service": "route53.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.worker.arn}"
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
  name        = "${aws_iam_role.worker.name}-route53"
  description = "Route53 policy for ${var.name}"
  policy      = data.aws_iam_policy_document.route53.json
  path        = "/"
}

data "aws_iam_policy_document" "route53" {
  statement {
    sid    = "eksWorkerRoute53Update"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*",
    ]
  }

  statement {
    sid    = "eksWorkerRoute53Select"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
    resources = ["*"]
  }
}
