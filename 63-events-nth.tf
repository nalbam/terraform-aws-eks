# cloudwatch events

# EC2 Spot Instance Interruption Warning

resource "aws_cloudwatch_event_rule" "nth_spot" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-spot-interruption", local.sqs_nth)
  description = "EC2 Spot Instance Interruption Warning"

  event_pattern = jsonencode(
    {
      "source" : [
        "aws.ec2"
      ]
      "detail-type" : [
        "EC2 Spot Instance Interruption Warning"
      ]
      "detail" : {
        "instance-action": [ "terminate" ]
      }
    }
  )

  tags = merge(
    local.tags,
    {
      "Name" = format("%s-spot-interruption", local.sqs_nth)
    },
  )
}

resource "aws_cloudwatch_event_target" "nth_spot" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-spot-interruption", local.sqs_nth)
  rule      = aws_cloudwatch_event_rule.nth_spot.0.name
  arn       = aws_sqs_queue.nth.arn
}

# EC2 Instance State-change Notification

resource "aws_cloudwatch_event_rule" "nth_state" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-state-change", local.sqs_nth)
  description = "EC2 Instance State-change Notification"

  event_pattern = jsonencode(
    {
      "source" : [
        "aws.ec2"
      ]
      "detail-type" : [
        "EC2 Instance State-change Notification"
      ]
      "detail": {
        "state": [ "shutting-down" ]
      }
    }
  )

  tags = merge(
    local.tags,
    {
      "Name" = format("%s-state-change", local.sqs_nth)
    },
  )
}

resource "aws_cloudwatch_event_target" "nth_state" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-state-change", local.sqs_nth)
  rule      = aws_cloudwatch_event_rule.nth_state.0.name
  arn       = aws_sqs_queue.nth.arn
}

# AWS Health Event

resource "aws_cloudwatch_event_rule" "nth_scheduled" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-scheduled-change", local.sqs_nth)
  description = "AWS Health Event"

  event_pattern = jsonencode(
    {
      "source" : [
        "aws.health"
      ]
      "detail-type" : [
        "AWS Health Event"
      ]
      "detail": {
        "service": [ "EC2" ]
        "eventTypeCategory": [ "scheduledChange" ]
      }
    }
  )

  tags = merge(
    local.tags,
    {
      "Name" = format("%s-scheduled-change", local.sqs_nth)
    },
  )
}

resource "aws_cloudwatch_event_target" "nth_scheduled" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-scheduled-change", local.sqs_nth)
  rule      = aws_cloudwatch_event_rule.nth_scheduled.0.name
  arn       = aws_sqs_queue.nth.arn
}
