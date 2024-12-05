output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "node_group_name" {
  value = aws_eks_node_group.node_group.node_group_name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}
