resource "aws_eks_cluster" "EKs_Cluster" {
  name = "EKS_Cluster"
access_config {
    authentication_mode = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
}

#role_arn = aws_iam_role.eks_cluster_role.arn     ## Attech IAM Role to The Kubernates 
role_arn = data.aws_iam_role.lab_role.arn 
version  = "1.29"


## For AZ for normal you need at least two AZ and for High Avaliability you need 3 AZ 
vpc_config {
    subnet_ids = [
      aws_subnet.Zone1.id,
      aws_subnet.Zone2.id,
      aws_subnet.Zone3.id,
    ]
}
}

resource "aws_eks_node_group" "EKS_NodeGroup" {
  cluster_name    = aws_eks_cluster.EKs_Cluster.name
  node_group_name = "EKS_Feedback"
  #node_role_arn   = aws_iam_role.eks_node_role.arn
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids = [
      aws_subnet.Zone1.id,
      aws_subnet.Zone2.id,
      aws_subnet.Zone3.id,
    ]

  instance_types= ["t2.micro"]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

tags = {
  Name = "EKS_Feedback_Nodes"
}
}
