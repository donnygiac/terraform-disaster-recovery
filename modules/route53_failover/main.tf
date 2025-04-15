resource "aws_route53_health_check" "primary_health" {
  fqdn              = var.primary_fqdn
  type              = var.health_check_type
  resource_path     = var.health_check_path
  failure_threshold = var.health_check_failure_threshold
  request_interval  = var.health_check_interval
}

resource "aws_route53_record" "primary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  set_identifier = "primary"

  alias {
    name                   = var.primary_elb_dns
    zone_id                = var.primary_elb_zone_id
    evaluate_target_health = var.evaluate_target_health
  }

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

  ttl     = var.secondary_ttl
  records = [var.secondary_ip]

  failover_routing_policy {
    type = "SECONDARY"
  }
}
