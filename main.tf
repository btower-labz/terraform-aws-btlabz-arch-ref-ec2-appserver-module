resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

locals {
  name = var.name == "" ? random_pet.name.id : var.name
}

resource "aws_instance" "main" {
  ami                     = local.ami
  instance_type           = var.size
  tenancy                 = "default"
  ebs_optimized           = false
  disable_api_termination = false
  key_name                = var.key
  monitoring              = false

  iam_instance_profile    = "${aws_iam_instance_profile.main.name}"

  source_dest_check = true

  //vpc_security_group_ids = [
  //  "${data.terraform_remote_state.sec.nat_sg}",
  //]

  subnet_id = var.subnet

  user_data = local.userdata

  # Prevent destroy on user data change.
  lifecycle {
    ignore_changes = [
      user_data,
      ami,
    ]

    prevent_destroy = true
  }

  # Prevent automated deletion.
  # disable_api_termination = false

  tags = merge(
    map(
      "Name", local.name
    ),
    var.tags
  )
}
