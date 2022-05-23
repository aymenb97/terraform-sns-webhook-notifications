terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }
}
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-sns-notify"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
data "archive_file" "lambda_webhook_attach" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/lambda-sns-notify.zip"
}
resource "aws_lambda_function" "lambda_webhook" {
  function_name    = var.function_name
  runtime          = "python3.8"
  timeout          = "15"
  handler          = "func.lambda_handler"
  filename         = "${path.module}/lambda-sns-notify.zip"
  source_code_hash = data.archive_file.lambda_webhook_attach.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
  environment {
    variables = {
      SLACK_ENDPOINT = var.slack_endpoint
    }
  }
}
output "arn" {
  value = aws_lambda_function.lambda_webhook.arn
}
resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.lambda_exec.name
  policy_arn = each.key
}
