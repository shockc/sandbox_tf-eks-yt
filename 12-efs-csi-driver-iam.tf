
data "aws_iam_policy_document" "paul-eks-csi-efs" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.paul-eks-eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.paul-eks-eks.arn]
      type        = "Federated"
    }
  }
}

# output "efs" {
#   value = data.aws_iam_policy_document.csi-efs.json
# }

resource "aws_iam_policy" "paul-eks-eks_efs_csi_driver_policy" {
  name = "paul-eks-AmazonEKS_EFS_CSI_Driver_Policy"
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeMountTargets",
        "ec2:DescribeAvailabilityZones"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:CreateAccessPoint"
      ],
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "aws:RequestTag/efs.csi.aws.com/cluster": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:TagResource"
      ],
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "elasticfilesystem:DeleteAccessPoint",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
        }
      }
    }
  ]
})
}

resource "aws_iam_role" "paul-eks-eks_efs_csi_driver" {
  assume_role_policy = data.aws_iam_policy_document.paul-eks-csi-efs.json
  name               = "paul-eks-eks-efs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "paul-eks-amazon_efs_csi_driver" {
  role       = aws_iam_role.paul-eks-eks_efs_csi_driver.name
  # policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.paul-eks-current.account_id}:policy/${aws_iam_policy.paul-eks-eks_efs_csi_driver_policy.name}"
}