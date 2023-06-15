data "aws_caller_identity" "current" {}
resource "aws_cloudtrail" "Nicotine_Gum" {
  name                          = var.cloud_trail_name
  s3_bucket_name                = aws_s3_bucket.log.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}
resource "aws_s3_bucket" "log" {
  bucket        = var.bucket_name
  force_destroy = true
}
data "aws_iam_policy_document" "Nicotin_GUM-cloudtrail_policy" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.log.arn]
  }
  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.log.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
resource "aws_s3_bucket_policy" "nicotingum" {
  bucket = aws_s3_bucket.log.id
  policy = data.aws_iam_policy_document.Nicotin_GUM-cloudtrail_policy.json
}