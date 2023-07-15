resource "aws_route53_record" "querocodar_domain_a" {
  zone_id = var.aws_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.querocodar_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.querocodar_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "querocodar_domain_a_www" {
  zone_id = var.aws_zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.querocodar_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.querocodar_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}
