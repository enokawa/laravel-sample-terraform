# ALB
resource "aws_lb" "sample-alb-01" {
  name               = "sample-alb-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sample-lb-sg-01.id}"]

  subnets = [
    "${aws_subnet.sample-public-a.id}",
    "${aws_subnet.sample-public-c.id}",
  ]

  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  idle_timeout                     = 120
  ip_address_type                  = "ipv4"

  tags = {
    Name = "sample-alb-01"
  }
}


# Listener
resource "aws_lb_listener" "sample-alb-01-http" {
  load_balancer_arn = "${aws_lb.sample-alb-01.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.sample-alb-01-tg-01.arn}"
    type             = "forward"
  }
}


# TargetGroup
resource "aws_lb_target_group" "sample-alb-01-tg-01" {
  name        = "sample-alb-01-tg-01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.sample-vpc-01.id}"
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = 10
    matcher             = "200"
  }

  tags = {
    Name = "sample-alb-01-tg-01"
  }
}
