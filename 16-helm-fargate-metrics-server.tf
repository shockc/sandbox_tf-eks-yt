provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.paul-eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.paul-eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.paul-eks.id]
      command     = "aws"
    }
  }
}

resource "helm_release" "paul-eks-metrics-server" {
  name = "paul-eks-metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "fargate-kube-system"
  create_namespace = true
  version    = "3.8.2"

  set {
    name  = "metrics.enabled"
    value = false
  }

  depends_on = [aws_eks_fargate_profile.paul-eks-eks-fargate]
}