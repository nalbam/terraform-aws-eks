# sqs

locals {
  sqs_nth  = format("%s-nth", var.cluster_name)
  sqs_spot = format("%s-spot", var.cluster_name)
}

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

resource "aws_sqs_queue" "nth" {
  name = local.sqs_nth

  message_retention_seconds = 300

  policy = data.aws_iam_policy_document.sqs.json

  tags = merge(
    local.tags,
    {
      "Name" = local.sqs_nth
    },
  )
}

resource "aws_sqs_queue" "spot" {
  name = local.sqs_spot

  message_retention_seconds = 300

  policy = data.aws_iam_policy_document.sqs.json

  tags = merge(
    local.tags,
    {
      "Name" = local.sqs_spot
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
      "arn:aws:sqs:${var.region}:${var.account_id}:${local.worker_name}",
      "arn:aws:sqs:${var.region}:${var.account_id}:${local.sqs_nth}",
      "arn:aws:sqs:${var.region}:${var.account_id}:${local.sqs_spot}",
    ]
  }
}
