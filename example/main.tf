module "sns_notify" {
  source         = "../"
  emails         = ["ayman.bellakhder@pi-square.io"]
  policy_arns    = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  function_name  = "sns-notify"
  slack_endpoint = "YOUR_SLACK_WEB_HOOK"
}
