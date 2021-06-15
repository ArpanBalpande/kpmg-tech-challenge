data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "this" {
  description = "Allow HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  security_group_id = aws_security_group.this.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_launch_configuration" "this" {
  name_prefix     = "kpmg-lc"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.this.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  availability_zones        = ["us-east-2a", "us-east-2b"]
  name                      = var.asg_name
  launch_configuration      = aws_launch_configuration.this.name
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  #   vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

  initial_lifecycle_hook {
    name                 = "kpmg"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = <<EOF
{
  "foo": "bar"
}
EOF

    # notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    # role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  }

  tag {
    key                 = "name"
    value               = "kpmg"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  lifecycle {
    create_before_destroy = true
  }
}