resource "aws_iam_instance_profile" "main" {
  name = format("%s-role", local.name)
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  name               = format("%s-role", local.name)
  assume_role_policy = file("${path.module}/policy/ec2-trust.json")
}

resource "aws_iam_role_policy_attachment" "ecs_full" {
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}
