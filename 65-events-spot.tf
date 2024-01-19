# cloudwatch events

# EC2 Spot Instance Interruption Warning

resource "aws_cloudwatch_event_rule" "spot" {
  count = var.enable_event ? 1 : 0

  name        = format("%s-spot-interruption", local.sqs_spot)
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
      "Name" = format("%s-spot-interruption", local.sqs_spot)
    },
  )
}

resource "aws_cloudwatch_event_target" "spot" {
  count = var.enable_event ? 1 : 0

  target_id = format("%s-spot-interruption", local.sqs_spot)
  rule      = aws_cloudwatch_event_rule.spot.0.name
  arn       = aws_sqs_queue.spot.arn
}
