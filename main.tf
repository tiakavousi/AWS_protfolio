# VPC
module "vpc" {
  source     = "./modules/network/vpc"
  cidr_block = var.cidr_block
}

# Subnets
module "subnets" {
  source           = "./modules/network/subnets"
  vpc_id           = module.vpc.vpc_id
}

# Configure Routes
module "route" {
  source           = "./modules/network/route"
  subnets          = module.subnets.subnets
  public_subnet_id = module.subnets.public_subnet_id
  vpc_id           = module.vpc.vpc_id
}

# ASG Security Group
module "sec_group" {
  source         = "./modules/network/sec_group"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = var.cidr_block
}

# Load Balancer
module "lb" {
  source                   = "./modules/network/lb"
  vpc_security_group_name  = ["sg-1", "sg-2"]
  vpc_id                   = module.vpc.vpc_id
  subnet_group_public_ids  = module.subnets.subnet_group_public_ids
  security_group_id        = module.sec_group.security_group_id
}

# Auto Scalling Group
module "asg" {
  source                  = "./modules/compute/asg"
  ami_id                  = var.ami_id
  target_group_arn        = module.lb.target_group_arn
  subnet_group_private_ids = module.subnets.subnet_group_private_ids
  security_group          = module.sec_group.security_group_id
}

# S3 Bucket
module "s3" {
  source  = "./modules/storage/s3"
}
