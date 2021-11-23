variable "EVENT_SCHEDULE" {}

resource "aws_cloudwatch_event_rule" "cloudwatch_schedular" {
  name = "weather_notification_trigger"
  description = "Trigger weather notification for the given time"
  schedule_expression = "cron(${var.EVENT_SCHEDULE})"
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule = aws_cloudwatch_event_rule.cloudwatch_schedular.name
  arn = aws_lambda_function.main.arn
}
