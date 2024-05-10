resource "aws_iam_role" "paul-eks" {
  name = "paul-eks-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "paul-eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.paul-eks.name
}

variable "cluster_name" {
  default = "paul-eks"
  type = string
  description = "AWS EKS CLuster Name"
  nullable = false
}

resource "aws_eks_cluster" "paul-eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.paul-eks.arn
  version  = "1.27"

  vpc_config {
    subnet_ids = [
      "subnet-0aea2919da32c9aa8",
      "subnet-03c5ccd0beecb27ff",
      "subnet-07ad170691c694824",
      "subnet-046992d58767ca046"
    ]
    # Private access to the EKS control plane
    ##Auto create EndPoint private Access. 
    ## Need to add the ec2 IPs in Secgroup (auto created by AWS). 
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [aws_iam_role_policy_attachment.paul-eks-AmazonEKSClusterPolicy]
}

