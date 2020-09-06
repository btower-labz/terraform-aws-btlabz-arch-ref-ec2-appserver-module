# Recovery alarm as per: 
# https://aws.amazon.com/blogs/aws/new-auto-recovery-for-amazon-ec2/
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-recover.html

resource "aws_cloudwatch_metric_alarm" "recovery" {
  alarm_name          = format("%s-ec2-recovery", local.name)
  alarm_description   = "EC2 Recovery Alarm (${local.name}). It will recover the instance in case of a failure."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  actions_enabled     = true

  alarm_actions = [
    "arn:aws:automate:${local.region_name}:ec2:recover",
  ]

  metric_name = "StatusCheckFailed_System"

  dimensions = {
    InstanceId = aws_instance.main.id
  }

  period             = 60
  treat_missing_data = "missing"
  threshold          = 1
  evaluation_periods = 3
  statistic          = "Average"
}
