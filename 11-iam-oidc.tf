data "tls_certificate" "paul-eks-eks" {
  url = aws_eks_cluster.paul-eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "paul-eks-eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.paul-eks-eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.paul-eks.identity[0].oidc[0].issuer
}

#get aws account id
data "aws_caller_identity" "paul-eks-current" {}

