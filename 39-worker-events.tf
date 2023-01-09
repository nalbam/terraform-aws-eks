# cloudwatch events

# EC2 Spot Instance Interruption Warning

resource "aws_cloudwatch_event_rule" "nth_spot" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-spot-interruption", local.worker_name)
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
}

resource "aws_cloudwatch_event_target" "nth_spot" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-spot-interruption", local.worker_name)
  rule      = aws_cloudwatch_event_rule.nth_spot.0.name
  arn       = aws_sqs_queue.worker.arn
}

# EC2 Instance Rebalance Recommendation

# resource "aws_cloudwatch_event_rule" "nth_rebal" {
#   count = var.enable_event ? var.capacity_rebalance ? 1 : 0 : 0

#   name        = format("%s-rebalance", local.worker_name)
#   description = "EC2 Instance Rebalance Recommendation"
#   event_pattern = jsonencode(
#     {
#       "source" : [
#         "aws.ec2"
#       ]
#       "detail-type" : [
#         "EC2 Instance Rebalance Recommendation"
#       ]
#     }
#   )
# }

# resource "aws_cloudwatch_event_target" "nth_rebal" {
#   count = var.enable_event ? var.capacity_rebalance ? 1 : 0 : 0

#   target_id = format("%s-rebalance", local.worker_name)
#   rule      = aws_cloudwatch_event_rule.nth_rebal.0.name
#   arn       = aws_sqs_queue.worker.arn
# }

# EC2 Instance State-change Notification

resource "aws_cloudwatch_event_rule" "nth_state" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-state-change", local.worker_name)
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
}

resource "aws_cloudwatch_event_target" "nth_state" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-state-change", local.worker_name)
  rule      = aws_cloudwatch_event_rule.nth_state.0.name
  arn       = aws_sqs_queue.worker.arn
}

# AWS Health Event

resource "aws_cloudwatch_event_rule" "nth_scheduled" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-scheduled-change", local.worker_name)
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
}

resource "aws_cloudwatch_event_target" "nth_scheduled" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-scheduled-change", local.worker_name)
  rule      = aws_cloudwatch_event_rule.nth_scheduled.0.name
  arn       = aws_sqs_queue.worker.arn
}
