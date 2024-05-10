
data "aws_iam_policy_document" "paul-eks-csi-ebs" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.paul-eks-eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.paul-eks-eks.arn]
      type        = "Federated"
    }
  }
}

# output "ebs" {
#   value = data.aws_iam_policy_document.csi-ebs.json
# }

resource "aws_iam_role" "paul-eks-eks_ebs_csi_driver" {
  assume_role_policy = data.aws_iam_policy_document.paul-eks-csi-ebs.json
  name               = "paul-eks-eks-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "paul-eks-amazon_ebs_csi_driver" {
  role       = aws_iam_role.paul-eks-eks_ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}