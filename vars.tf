variable "enable_lambda_sub" {
  description = "Enable Lambda Webhook SNS subscription"
  type        = bool
  default     = true
}
variable "enable_email_subscription" {
  description = "Enable Description for email"
  type        = bool
  default     = true
}
variable "emails" {
  description = "List of emails subscriptions"
  type        = list(string)
}
variable "policy_arns" {
  description = "Policy ARNs to attach to the lambda functions"

}
variable "function_name" {
  default     = "sns-notify"
  description = "Name of the lambda function"

}
variable "slack_endpoint" {
  description = "Endpoint of the slack endpoint"
}
