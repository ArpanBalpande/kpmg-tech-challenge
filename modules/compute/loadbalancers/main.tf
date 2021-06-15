// External Load Balancer
resource "aws_security_group" "external" {
  description = "Allow connection between ALB and target"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "external" {
  security_group_id = aws_security_group.external.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_s3_bucket" "this" {
#   bucket = "kpmg-lb-bucket"
#   acl    = "public-read"

#   tags = {
#     Name = "KPMG bucket"
#   }
# }

resource "aws_lb" "external" {
  name               = "kpmg-external-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.external.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = true

  #   access_logs {
  #     bucket  = aws_s3_bucket.this.bucket
  #     prefix  = "external-lb"
  #     enabled = true
  #   }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "external" {
  load_balancer_arn = aws_lb.external.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external.arn
  }
}

resource "aws_lb_target_group" "external" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  load_balancing_algorithm_type = "least_outstanding_requests"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
  }

  depends_on = [
    aws_lb.external
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "external" {
  autoscaling_group_name = var.public_autoscaling_group_name
  alb_target_group_arn   = aws_lb_target_group.external.arn
}

// Internal Load Balancer
resource "aws_security_group" "internal" {
  description = "Allow connection between ALB and target"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "internal" {
  security_group_id = aws_security_group.external.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_s3_bucket" "this" {
#   bucket = "kpmg-lb-bucket"
#   acl    = "public-read"

#   tags = {
#     Name = "KPMG bucket"
#   }
# }

resource "aws_lb" "internal" {
  name               = "kpmg-internal-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal.id]
  subnets            = var.private_subnet_ids

  enable_deletion_protection = true

  #   access_logs {
  #     bucket  = aws_s3_bucket.this.bucket
  #     prefix  = "external-lb"
  #     enabled = true
  #   }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal.arn
  }
}

resource "aws_lb_target_group" "internal" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  load_balancing_algorithm_type = "least_outstanding_requests"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
  }

  depends_on = [
    aws_lb.external
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "internal" {
  autoscaling_group_name = var.private_autoscaling_group_name
  alb_target_group_arn   = aws_lb_target_group.internal.arn
}