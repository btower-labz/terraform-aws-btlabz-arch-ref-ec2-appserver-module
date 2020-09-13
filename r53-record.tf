variable "zone_id" {
  type        = string
  description = "R53 zone identifier to create name records for the instance"
  default     = ""
}

variable "dns_name" {
  type        = string
  description = "R53 record name for the instance"
  default     = ""
}

variable "dns_record_ttl" {
  type        = number
  description = "DNS recort TTL in seconds"
  default     = 60
}

locals {
  dns_name = var.dns_name == "" ? local.name : var.dns_name
}

data "aws_route53_zone" "primary" {
  count   = var.zone_id == "" ? 0 : 1
  zone_id = var.zone_id
}

resource "aws_route53_record" "main" {
  count   = var.zone_id == "" ? 0 : 1
  zone_id = data.aws_route53_zone.primary[0].zone_id
  name    = local.dns_name
  type    = "A"
  ttl     = var.dns_record_ttl
  records = [
    aws_instance.main.private_ip
  ]
}

output "fqdn" {
  description = "Fully qualified domain name of the instance"
  value       = var.zone_id == "" ? null : aws_route53_record.main[0].fqdn
}

output "dns_name" {
  description = "The actual dns name of the record"
  value       = var.zone_id == "" ? null : aws_route53_record.main[0].name
}
