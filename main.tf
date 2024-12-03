provider "aws" {
  region = "us-west-2" # Specify your region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "public_subnets" {
  source          = "./modules/subnet"
  vpc_id          = module.vpc.vpc_id
  cidr_blocks     = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b"]
  public          = true
}

module "private_subnets" {
  source          = "./modules/subnet"
  vpc_id          = module.vpc.vpc_id
  cidr_blocks     = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b"]
  public          = false
}

module "igw" {
  source  = "./modules/internet_gateway"
  vpc_id  = module.vpc.vpc_id
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.public_subnets.subnet_ids[0] # NAT in first public subnet
  allocation_id    = aws_eip.nat_eip.id
}

module "public_route_table" {
  source               = "./modules/route_table"
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.igw.igw_id
  subnet_ids           = module.public_subnets.subnet_ids
  public               = true
}

module "private_route_table" {
  source               = "./modules/route_table"
  vpc_id               = module.vpc.vpc_id
  nat_gateway_id       = module.nat_gateway.nat_gateway_id
  subnet_ids           = module.private_subnets.subnet_ids
  public               = false
}

resource "aws_eip" "nat_eip" {
  vpc = true
}
