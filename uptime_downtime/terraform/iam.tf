# IAM Role to allow Lambda access to EC2 and KMS

resource "aws_iam_role" "iam_role_uptime_downtime" {
  name = "Lambda_Uptime_Downtime_Function"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowLambdaAssumeRole",
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "lambda.amazonaws.com"
          ]
        }
      }
    ]
  })
}


resource "aws_iam_policy" "iam_policy_lambda_uptime_downtime_ec2" {
  name        = "Lambda-Uptime-Downtime-EC2"
  path        = "/"
  description = "Iam Policy to allow Lambda Function Uptime Downtime to Stop or Start EC2 instances, including KMS encrypted volumes and CloudWatch Logging"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ManageKMSKeys",
        "Effect" : "Allow",
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ],
        "Resource" : [
          "arn:aws:license-manager:*:${var.aws_account_id}:license-configuration/*",
          "arn:aws:kms:*:${var.aws_account_id}:key/*"
        ]
      },
      {
        "Sid" : "StopStartEC2Instances",
        "Effect" : "Allow",
        "Action" : [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        "Resource" : "arn:aws:ec2:*:${var.aws_account_id}:instance/*"
      },
      {
        "Sid" : "DescribeEC2Instances",
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstances"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "CreateCloudWatchLog",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ],
        "Resource" : [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_lambda_uptime_downtime_attachment" {
  role       = aws_iam_role.iam_role_uptime_downtime.name
  policy_arn = aws_iam_policy.iam_policy_lambda_uptime_downtime_ec2.arn
}