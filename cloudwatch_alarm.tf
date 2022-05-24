resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "Monitor CPU Metric"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Triggers when CPU Usage Great or equal than 80"
  alarm_actions       = [aws_sns_topic.sns_notify.arn]
}
