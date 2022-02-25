variable "API_KEY" {}
variable "EMAILS" {}
variable "FROM_EMAIL" {}
variable "LOCATION_ID" {}

resource "aws_iam_policy" "ses_send_email" {
  policy = data.template_file.ses_send_email_policy.rendered
}

resource "aws_iam_role_policy_attachment" "lambda-ses-send-email" {
  policy_arn =  aws_iam_policy.ses_send_email.arn
  role = aws_iam_role.weather-app-policy.name
}

resource "aws_iam_role" "weather-app-policy" {
  assume_role_policy = data.template_file.lambda_assume_role_policy.rendered
}

resource "aws_iam_role_policy_attachment" "lambda-policy-role-attachment" {
  policy_arn =  "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.weather-app-policy.name
}

resource "aws_lambda_function" "main" {
  function_name = "weather-notifier"
  filename = "lambda.zip"
  handler = "app.lambda_handler"
  role = aws_iam_role.weather-app-policy.arn
  runtime = "python3.7"
  tracing_config.mode = "PassThrough"
  source_code_hash = filebase64sha256("lambda.zip")
  environment {
    variables = {
      API_KEY = var.API_KEY
      EMAILS = var.EMAILS
      FROM_EMAIL = var.FROM_EMAIL
      LOCATION_ID = var.LOCATION_ID
    }
  }
}
