resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule_uptime_downtime" {
  name                = "EC2-Downtime-5pm-AEST"
  description         = "Turn off DEV environment EC2 Instances 5pm AEST"
  schedule_expression = local.scheduled_stop_cron_expression
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target_uptime_downtime" {
  arn   = aws_lambda_function.lambda_function_uptime_downtime.arn
  rule  = aws_cloudwatch_event_rule.cloudwatch_event_rule_uptime_downtime.id
  input = <<JSON
  {
      "Environment": "DEV",
      "Action": "Stop",
      "Region": "${var.region}"
  }
  JSON
}