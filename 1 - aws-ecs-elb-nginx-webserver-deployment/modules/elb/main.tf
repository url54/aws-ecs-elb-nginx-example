resource "aws_lb" "main" {
  name               = "main-public-alb"
  internal           = false # This is now a public-facing ELB
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group]
  subnets            = var.public_subnets # Attach to public subnets
}

resource "aws_lb_target_group" "main" {
  name        = "alb-tg-nginx"
  port        = 80 # NGINX listens on port 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}