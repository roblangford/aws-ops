resource "aws_lambda_function" "lambda_function_uptime_downtime" {
  filename         = "./uptime_downtime.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_role_uptime_downtime.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("./uptime_downtime.zip")
  runtime          = "python3.9"
}