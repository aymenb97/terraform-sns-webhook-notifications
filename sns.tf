resource "aws_sns_topic" "sns_notify" {
  name = "SNS-Notify"
}

resource "aws_sns_topic_subscription" "lambda" {
  count     = var.enable_lambda_sub ? 1 : 0
  topic_arn = aws_sns_topic.sns_notify.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_webhook.arn
}
resource "aws_sns_topic_subscription" "email" {
  for_each  = toset(var.emails)
  topic_arn = aws_sns_topic.sns_notify.arn
  protocol  = "email"
  endpoint  = each.value
}
