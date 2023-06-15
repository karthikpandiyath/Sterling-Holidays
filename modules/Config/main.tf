resource "aws_config_aggregate_authorization" "example" {
  account_id = var.account_id
  region     = var.region
}
resource "aws_config_config_rule" "r" {
  name = var.config_name
  source {
    owner             = var.owner
    source_identifier = var.region
  }
  depends_on = [aws_config_configuration_recorder.foo]
}
resource "aws_config_configuration_recorder" "foo" {
  name     = var.config_recorder_name
  role_arn = aws_iam_role.r.arn
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "r" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
data "aws_iam_policy_document" "p" {
  statement {
    effect    = "Allow"
    actions   = ["config:Put*"]
    resources = ["*"]
  }
}
resource "aws_iam_role_policy" "p" {
  name   = var.assume_role_policy_name
  role   = aws_iam_role.r.id
  policy = data.aws_iam_policy_document.p.json
}