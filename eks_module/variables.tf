variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" {}
variable "public_subnet_ids" {}
variable "eks_cluster_role_name" {}
variable "eks_worker_role_name" {}
variable "desired_size" { default = 3 }
variable "min_size" { default = 2 }
variable "max_size" { default = 5 }
variable "instance_types" { default = ["t3.medium"] }
variable "cluster_version" { default = "1.29" }
variable "security_group_ids" { default = [] }
