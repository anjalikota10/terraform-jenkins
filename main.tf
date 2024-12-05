provider "aws" {
  region = "us-west-2" # Specify your region
}

module "vpc" {
  source = "./vpc_module/vpc"
  cidr_block = var.vpc_cidr_block
}

module "public_subnets" {
  source          = "./vpc_module/subnet"
  vpc_id          = module.vpc.vpc_id
  cidr_blocks     = var.public_subnet_cidr_blocks
  availability_zones = var.availability_zones
  public          = true
}

module "private_subnets" {
  source          = "./vpc_module/subnet"
  vpc_id          = module.vpc.vpc_id
  cidr_blocks     = var.private_subnet_cidr_blocks
  availability_zones = var.availability_zones
  public          = false
}

module "igw" {
  source  = "./vpc_module/IGW"
  vpc_id  = module.vpc.vpc_id
}

module "nat_gateway" {
  source           = "./vpc_module/NAT"
  public_subnet_id = module.public_subnets.subnet_ids[0] # NAT in first public subnet
  allocation_id    = aws_eip.nat_eip.id
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

module "public_route_table" {
  source               = "./vpc_module/route_table"
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.igw.igw_id
  subnet_ids           = module.public_subnets.subnet_ids
  public               = true
}

module "private_route_table" {
  source               = "./vpc_module/route_table"
  vpc_id               = module.vpc.vpc_id
  nat_gateway_id       = module.nat_gateway.nat_gateway_id
  subnet_ids           = module.private_subnets.subnet_ids
  public               = false
}

# Call the EKS module
module "eks_cluster" {
  source = "./eks_module" # Path to your EKS module

  cluster_name           = "EKS-cluster"
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.private_subnets.subnet_ids # Using private subnets for worker nodes
  public_subnet_ids      = module.public_subnets.subnet_ids
  eks_cluster_role_name  = "EKSclusterrole1"
  eks_worker_role_name   = "workernodepolicy"
  desired_size           = 2
  min_size               = 1
  max_size               = 3
  instance_types         = ["t2.micro"]
  cluster_version        = "1.29"
}