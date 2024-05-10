resource "aws_eks_addon" "paul-eks-efs-csi_driver" {
  cluster_name             = aws_eks_cluster.paul-eks.name
  addon_name               = "aws-efs-csi-driver"
  addon_version            = "v2.0.1-eksbuild.1"
  service_account_role_arn = aws_iam_role.paul-eks-eks_efs_csi_driver.arn
}
# #aws eks describe-addon-versions --addon-name aws-ebs-csi-driver (can check addon version)
