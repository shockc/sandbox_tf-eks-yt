resource "aws_iam_role" "paul-eks-eks-fargate-profile" {
  name = "paul-eks-eks-fargate-profile"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "paul-eks-eks-fargate-profile-AmazonEKSFargatePodExecutionRolePolic" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.paul-eks-eks-fargate-profile.name
}

resource "aws_eks_fargate_profile" "paul-eks-eks-fargate" {
  cluster_name           = aws_eks_cluster.paul-eks.name
  fargate_profile_name   = "paul-eks-eks-fargate"
  pod_execution_role_arn = aws_iam_role.paul-eks-eks-fargate-profile.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = [
    "subnet-0aea2919da32c9aa8",
    "subnet-03c5ccd0beecb27ff"
    # aws_subnet.yt-eks-public-ap-northeast-1a.id,
    # aws_subnet.yt-eks-public-ap-northeast-1c.id
    ]

  selector {
    namespace = "fargate-kube-system"
  }
}