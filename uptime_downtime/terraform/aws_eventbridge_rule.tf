# EventBridge Rules: Stop Event
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule_uptime_downtime_stop" {
  count               = var.enable_eventbridge_rule_stop_ec2 ? 1 : 0 # Optional Component as an example
  name                = "EC2-Downtime-${var.scheduled_stop_hour}h_${var.scheduled_stop_minute}min-GMT"
  description         = "Turn off ${var.target_environment} environment EC2 Instances ${var.scheduled_stop_hour}h:${var.scheduled_stop_minute}min GMT"
  schedule_expression = local.scheduled_stop_cron_expression

}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target_uptime_downtime_stop" {
  count = var.enable_eventbridge_rule_stop_ec2 ? 1 : 0 # Optional Component as an example
  arn   = aws_lambda_function.lambda_function_uptime_downtime.arn
  rule  = aws_cloudwatch_event_rule.cloudwatch_event_rule_uptime_downtime_stop[0].id
  input = <<JSON
{
    "Environment": "${var.target_environment}",
    "Action": "Stop",
    "Region": "${var.region}"
}
  JSON
}



# EventBridge Rules: Start Event
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule_uptime_downtime_start" {
  count               = var.enable_eventbridge_rule_start_ec2 ? 1 : 0 # Optional Component as an example
  name                = "EC2-Uptime-${var.scheduled_start_hour}h_${var.scheduled_start_minute}min-GMT"
  description         = "Turn On ${var.target_environment} environment EC2 Instances ${var.scheduled_start_hour}h:${var.scheduled_start_minute}min GMT"
  schedule_expression = local.scheduled_start_cron_expression

}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target_uptime_downtime_start" {
  count = var.enable_eventbridge_rule_start_ec2 ? 1 : 0 # Optional Component as an example
  arn   = aws_lambda_function.lambda_function_uptime_downtime.arn
  rule  = aws_cloudwatch_event_rule.cloudwatch_event_rule_uptime_downtime_start[0].id
  input = <<JSON
{
    "Environment": "${var.target_environment}",
    "Action": "Start",
    "Region": "${var.region}"
}
  JSON
}