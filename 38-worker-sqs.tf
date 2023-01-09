# sqs

resource "aws_sqs_queue" "worker" {
  name = local.worker_name

  message_retention_seconds = 300

  policy = data.aws_iam_policy_document.sqs.json

  tags = merge(
    local.tags,
    {
      "Name" = local.worker_name
    },
  )
}

data "aws_iam_policy_document" "sqs" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com",
        "sqs.amazonaws.com",
      ]
    }
    actions = [
      "sqs:SendMessage",
    ]
    resources = [
      "arn:aws:sqs:${local.region}:${local.account_id}:${local.worker_name}",
    ]
  }
}
