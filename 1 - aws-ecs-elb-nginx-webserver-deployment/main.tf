module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "elb" {
  source = "./modules/elb"

  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnet_ids # Deploy ELB to public subnets
  alb_security_group = module.security_groups.alb_sg_id
}

module "ecs" {
  source = "./modules/ecs"

  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  aws_region           = var.aws_region
  private_subnets      = module.vpc.private_subnet_ids # ECS tasks remain in private subnets for security
  ecs_security_group   = module.security_groups.ecs_sg_id
  alb_target_group_arn = module.elb.alb_target_group_arn
  container_image_uri  = var.container_image_uri
}
