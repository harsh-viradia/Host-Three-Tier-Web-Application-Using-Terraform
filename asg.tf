module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "harsh-asg"

  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets
  target_group_arns         = module.alb.target_group_arns

  # Launch template
  launch_template_name        = "harsh-viradia-asg-template"
  launch_template_description = "Harsh-Viradia-lt"
  update_default_version      = true

  image_id          = data.aws_ami.web_ami.id
  instance_type     = "t2.micro"
  enable_monitoring = true
  ebs_optimized     = false
  user_data         = base64encode(templatefile("user_data_script.sh", { rds_endpoint = local.rds_endpoint }))
  security_groups   = [module.app_security_group.security_group_id]
  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 20
        volume_type           = "gp2"
      }
    }
  ]
  #  IAM Role & Instance Profile
  create_iam_instance_profile = true
  iam_role_name               = "harsh-viradia-ec2-ssm"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role ec2 SSM"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = var.iam_role_asg

  tag_specifications = [
    {
      resource_type = "instance"
      tags = { Name = "harsh-viradia",
      Owner = "harsh.viradia@intuitive.cloud" }
    },
    {
      resource_type = "volume"
      tags = { Name = "harsh-viradia",
      Owner = "harsh.viradia@intuitive.cloud" }
    }
  ]

  tags = var.tags
}
locals {
  rds_endpoint = module.records_private.route53_record_fqdn
  endpoint     = module.db.db_instance_id
}
output "rds_dns" {
  value = trim(module.db.db_instance_endpoint,":3306")
}