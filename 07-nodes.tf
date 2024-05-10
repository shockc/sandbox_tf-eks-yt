resource "aws_iam_role" "paul-eks-nodes" {
  name = "paul-eks-eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "paul-eks-nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.paul-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "paul-eks-nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.paul-eks-nodes.name
}

resource "aws_iam_role_policy_attachment" "paul-eks-nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.paul-eks-nodes.name
}
##This policy attachement is for SSM
resource "aws_iam_role_policy_attachment" "paul-eks-nodes-ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.paul-eks-nodes.name
}


resource "aws_eks_node_group" "paul-eks-private-nodes" {
  cluster_name    = aws_eks_cluster.paul-eks.name
  version = aws_eks_cluster.paul-eks.version
  # node_group_name = "paul-eks-private-nodes"
  node_group_name_prefix = "paul-eks-private-nodes"
  node_role_arn   = aws_iam_role.paul-eks-nodes.arn

  subnet_ids = [
    "subnet-0aea2919da32c9aa8",
    "subnet-03c5ccd0beecb27ff"
  ]
   remote_access {
    ec2_ssh_key = "_linux_key.ppk"
  }


  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]
#  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }


###This will associate the Nodes to the EBS volume
  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }

  depends_on = [
    aws_iam_role_policy_attachment.paul-eks-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.paul-eks-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.paul-eks-nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.paul-eks-nodes-ssm_policy_attachment,
  ]
    lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "paul-eks-node"
  }
}

##Template to associate EBS with EKS nodes
##EBS only within AZ, EFS Cross AZ
# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {
#       volume_size = 1
#       volume_type = "gp2"
#     }
#   }
# }
