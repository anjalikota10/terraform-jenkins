output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.public_subnets.subnet_ids
}

output "private_subnet_ids" {
  value = module.private_subnets.subnet_ids
}

output "eks_cluster_id" {
  value = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_security_group_id" {
  value = module.eks.eks_cluster_security_group_id
}
