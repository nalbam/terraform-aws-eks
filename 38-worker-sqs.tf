# aws-node-termination-handler

resource "aws_sqs_queue" "worker" {
  name = local.worker_name

  message_retention_seconds = 300

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "events.amazonaws.com",
          "sqs.amazonaws.com"
        ]
      },
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:${local.region}:${local.account_id}:${local.worker_name}"
    }
  ]
}
POLICY

  tags = {
    "Name"                                      = local.worker_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}
