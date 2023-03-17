module "db" {
  source = "terraform-aws-modules/rds/aws"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  identifier             = "harsh-viradia-rds"
  db_name                = "harsh"
  username               = "harsh"
  password               = "12345678"
  create_random_password = false

  port                 = "3306"
  family               = "mysql8.0"
  major_engine_version = "8.0"

  iam_database_authentication_enabled = false

  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [module.db_security_group.security_group_id]

  deletion_protection = false
  skip_final_snapshot = true

  tags = var.tags
}