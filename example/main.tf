module "sns_notify" {
  source         = "../"
  emails         = ["ayman.bellakhder@pi-square.io"]
  policy_arns    = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  function_name  = "sns-notify"
  slack_endpoint = "https://hooks.slack.com/services/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"
}
