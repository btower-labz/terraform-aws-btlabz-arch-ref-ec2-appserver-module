data "aws_caller_identity" "current" {}

data "aws_availability_zones" "default" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_availability_zones" "information" {
  state = "information"
}

data "aws_availability_zones" "impaired" {
  state = "impaired"
}

data "aws_availability_zones" "unavailable" {
  state = "unavailable"
}

data "aws_canonical_user_id" "current" {}

data "aws_region" "current" {}

locals {
  account_id  = "${data.aws_caller_identity.current.account_id}"
  caller_arn  = "${data.aws_caller_identity.current.arn}"
  caller_id   = "${data.aws_caller_identity.current.user_id}"
  region_name = "${data.aws_region.current.name}"
  region_ep   = "${data.aws_region.current.endpoint}"
}
