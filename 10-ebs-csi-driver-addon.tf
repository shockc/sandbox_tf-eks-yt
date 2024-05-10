resource "aws_eks_addon" "paul-eks-ebs-csi_driver" {
  cluster_name             = aws_eks_cluster.paul-eks.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.30.0-eksbuild.1"
  service_account_role_arn = aws_iam_role.paul-eks-eks_ebs_csi_driver.arn
}
# #aws eks describe-addon-versions --addon-name aws-ebs-csi-driver (can check addon version)

