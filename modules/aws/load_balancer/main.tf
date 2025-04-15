# Crea il Load Balancer
resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]

  tags = var.tags
}

# Crea un target group
resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    matcher             = var.health_check_matcher
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = var.tags
}

# Crea un listener per il Load Balancer
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# Crea un target group attachment per ogni istanza associata al Load Balancer
resource "aws_lb_target_group_attachment" "this" {
  for_each = toset(var.instance_ids)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value
  port             = var.target_group_port
}
