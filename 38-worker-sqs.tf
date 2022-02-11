# aws-node-termination-handler

# data "aws_iam_policy_document" "sqs" {
#   statement {
#     effect = "Allow"
#     principals {
#       type = "Service"
#       identifiers = [
#         "events.amazonaws.com",
#         "sqs.amazonaws.com",
#       ]
#     }
#     actions = [
#       "sqs:SendMessage",
#     ]
#     resources = [
#       "arn:aws:sqs:${local.region}:${local.account_id}:${local.worker_name}",
#     ]
#   }
# }

resource "aws_sqs_queue" "worker" {
  name = local.worker_name

  message_retention_seconds = 300

  # policy = data.aws_iam_policy_document.sqs.json
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
