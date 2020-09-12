variable "amazon_ssm_managed_instance_core" {
  type = bool
  description = "Enable AmazonSSMManagedInstanceCore managed policy"
  default = true
}

variable "cloud_watch_agent_server_policy" {
  type = bool
  description = "Enable CloudWatchAgentServerPolicy managed policy"
  default = true
}

resource "aws_iam_instance_profile" "main" {
  name = format("%s-role", local.name)
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  name               = format("%s-role", local.name)
  assume_role_policy = file("${path.module}/policy/ec2-trust.json")
}

resource "aws_iam_role_policy_attachment" "amazon_ssm_managed_instance_core" {
  count      = var.amazon_ssm_managed_instance_core?1:0
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloud_watch_agent_server_policy" {
  count      = var.cloud_watch_agent_server_policy?1:0
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
