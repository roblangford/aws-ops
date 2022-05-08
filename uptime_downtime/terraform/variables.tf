# Define variable for AWS region 
variable "region" {
  type        = string
  description = "Input the AWS region in which you want to host and execute this lambda"
  default     = "ap-southeast-2"
}

# Define variable for AWS account id
variable "aws_account_id" {
  type        = string
  description = "Input your AWS Account ID"
}

variable "lambda_function_name" {
  type        = string
  description = "Input a name to identify your AWS Lambda Function"
  default     = "uptime_downtime_function"
}

variable "target_environment" {
  type        = string
  description = "Input a target Environment tag to execute against."
  default     = "DEV"
}

variable "enable_cloudwatch_logging" {
  type        = bool
  description = "Set to True to enable CloudWatch Logging"
  default     = true
}

variable "enable_example_eventbridge_rule_stop_ec2" {
  type        = bool
  description = "Set to True to deploy the example EventBridge Rule - Stop EC2 Environment:DEV, 5pm AEST"
  default     = false
}

variable "ec2_volumes_ecrypted" {
  type        = bool
  description = "Set to True if you have encrypted your EC2 Volumes"
  default     = false
}

variable "lambda_cloudwatch_log_retention" {
  type        = number
  description = "Input a number of days to store CloudWatch Logs"
  default     = 14
}

variable "scheduled_stop_hour" {
  type        = number
  description = "Enter the UTC hour that you wish to Stop the EC2 Instances"
  default     = 7
}

variable "scheduled_stop_minute" {
  type        = number
  description = "Enter the Minute that you wish to Stop the EC2 Instances"
  default     = 0
}

locals {
  scheduled_stop_cron_expression = "cron(${var.scheduled_stop_minute} ${var.scheduled_stop_hour} * * ? *)"
}