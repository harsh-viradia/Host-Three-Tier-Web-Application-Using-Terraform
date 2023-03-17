module "records_public" {
  source = "terraform-aws-modules/route53/aws//modules/records"
  version = "~>2.0"

  zone_id=data.aws_route53_zone.public_zone.id

  records=[{
  name    = "harsh-viradia-alb"
  type    = "CNAME"
  ttl     = 300
  records = [module.alb.lb_dns_name]
}]
}
module "records_private" {
  source = "terraform-aws-modules/route53/aws//modules/records"
  version = "~>2.0"

  zone_id=data.aws_route53_zone.private_zone.id
  

  records=[{
  name    = "harsh-viradia-rds"
  type    = "CNAME"
  ttl     = 300
  records = [trim(module.db.db_instance_endpoint,":3306")]
}]
}

resource "aws_route53_zone_association" "records_private" {
  zone_id = data.aws_route53_zone.private_zone.id
  vpc_id  = module.vpc.vpc_id
}
