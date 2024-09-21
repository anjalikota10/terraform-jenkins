output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.public_subnets.subnet_ids
}

output "private_subnet_ids" {
  value = module.private_subnets.subnet_ids
}
