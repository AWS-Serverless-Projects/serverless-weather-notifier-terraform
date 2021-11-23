provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

data "template_file" "lambda_assume_role_policy" {
  template = file("./policies/iam_assume_policy.json")
}

data "template_file" "ses_send_email_policy" {
  template = file("./policies/ses_send_email.json")
}