# If CloudWatch variable is enabled the following code will be deployed

resource "aws_cloudwatch_log_group" "cloudwatch_log_group_lambda_function_uptime_downtime" {
  count             = var.enable_cloudwatch_logging ? 1 : 0
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.lambda_cloudwatch_log_retention
}

resource "aws_iam_policy" "lambda_logging_uptime_downtime" {
  name        = "lambda_logging_uptime_downtime"
  path        = "/"
  description = "IAM policy for logging from uptime/downtime lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_role_uptime_downtime.name
  policy_arn = aws_iam_policy.lambda_logging_uptime_downtime.arn
}