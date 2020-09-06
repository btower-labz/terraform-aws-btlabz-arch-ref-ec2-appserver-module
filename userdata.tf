variable "userdata" {
  description = "Override module's userdata"
  type        = string
  default     = ""
}

// Instance runtime configuration files

locals {
  sample_config = templatefile("${path.module}/templates/sample.config", {
    foo = "bar"
  })
}

// Cloud init YAML

locals {
  cloud_init = templatefile("${path.module}/templates/cloud-init.yml", {
    b64_sample_config  = "${base64encode(local.sample_config)}",
    path_sample_config = "/etc/sample.config"
  })
}

// Provision scripts

locals {
  bootstrap_script_default   = templatefile("${path.module}/templates/bootstrap-default.sh", {})
  bootstrap_script_ssm_agent = templatefile("${path.module}/templates/bootstrap-ssm-agent.sh", {})
  bootstrap_script_aws_cli   = templatefile("${path.module}/templates/bootstrap-aws-cli.sh", {})
}

// Multipart config

data "template_cloudinit_config" "main" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "ud_cloud_init"
    content_type = "text/cloud-config"
    content      = local.cloud_init
  }

  part {
    filename     = "ud_script_default"
    content_type = "text/x-shellscript"
    content      = local.bootstrap_script_default
  }

  part {
    filename     = "ud_script_ssm_agent"
    content_type = "text/x-shellscript"
    content      = local.bootstrap_script_ssm_agent
  }

  part {
    filename     = "ud_script_awscli"
    content_type = "text/x-shellscript"
    content      = local.bootstrap_script_aws_cli
  }
}

// Final userdata script

locals {
  userdata = "${var.userdata == "" ? data.template_cloudinit_config.main.rendered : var.userdata}"
}
