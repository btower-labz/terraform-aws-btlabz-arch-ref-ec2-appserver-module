output "instance_id" {
  description = "EC2 instance identifier"
  value       = aws_instance.main.id
}

output "private_ip" {
  description = "EC2 instance private ip address."
  value       = "${aws_instance.main.private_ip}"
}
