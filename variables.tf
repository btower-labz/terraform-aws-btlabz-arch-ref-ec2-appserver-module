variable "name" {
  type        = string
  description = "EC2 instance name. Will be used for object naming"
  default     = ""
}

variable "key" {
  description = "EC2 instance EC2 key."
  type        = string
  default     = ""
}

variable "size" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.small"
}

variable "config_path" {
  description = "Configuration path for SSM and Secrets"
  type        = string
  default     = "/dev"
}

variable "security_groups" {
  description = "EC2 instance security groups."
  type        = list
  default     = []
}

variable "subnet" {
  description = "EC2 instance subnet id"
  type        = string
}

variable "tags" {
  description = "Additional tags. E.g. environment, backup tags etc."
  type        = map
  default     = {}
}
