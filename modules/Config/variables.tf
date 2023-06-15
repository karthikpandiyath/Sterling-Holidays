variable "account_id" {

}
variable "region" {
}
variable "config_name" {
  default = "example11"
}
variable "owner" {
  default = "AWS"
}
variable "source_identifier" {
  default = "S3_BUCKET_VERSIONING_ENABLED"
}
variable "config_recorder_name" {
  default = "example12"
}
variable "iam_role_name" {
  default = "my-awsconfig-role"
}
variable "assume_role_policy_name" {
  default = "my-awsconfig-policy"
}