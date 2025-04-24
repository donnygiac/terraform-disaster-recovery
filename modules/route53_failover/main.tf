resource "aws_route53_health_check" "primary_health" {
  ip_address        = var.primary_ip
  port              = var.health_check_port
  type              = var.health_check_type
  resource_path     = var.health_check_path
  failure_threshold = var.health_check_failure_threshold
  request_interval  = var.health_check_interval


  tags = merge(
    {
      name = "route53-primary-health"
    },
    var.custom_tags
  )

}

resource "aws_route53_record" "primary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  set_identifier = "primary"
  ttl            = var.ttl
  records        = [var.primary_ip]

  health_check_id = aws_route53_health_check.primary_health.id

  failover_routing_policy {
    type = "PRIMARY"
  }
}

resource "aws_route53_record" "secondary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  set_identifier = "secondary"
  ttl            = var.ttl
  records        = [var.secondary_ip]

  failover_routing_policy {
    type = "SECONDARY"
  }
}
