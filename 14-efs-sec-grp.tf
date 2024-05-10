resource "aws_security_group" "paul-eks-allow_nfs" {
  name        = "paul-eks-allow nfs for efs"
  description = "Allow NFS inbound traffic"
  vpc_id      = "vpc-0c688257a006f032b"

  ingress {
    description = "paul-eks-NFS from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.167.80.0/22"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


resource "aws_efs_file_system" "paul-eks-stw_node_efs" {
  creation_token = "paul-eks-efs"
  tags = {
    Name = "paul-eks-efs"
  }
}


resource "aws_efs_mount_target" "paul-eks-node_efs_mt_0" {
  file_system_id  = aws_efs_file_system.paul-eks-stw_node_efs.id
  subnet_id       = "subnet-0aea2919da32c9aa8"
  security_groups = [aws_security_group.paul-eks-allow_nfs.id]
}

resource "aws_efs_mount_target" "paul-eks-node_efs_mt_1" {
  file_system_id  = aws_efs_file_system.paul-eks-stw_node_efs.id
  subnet_id       = "subnet-03c5ccd0beecb27ff"
  security_groups = [aws_security_group.paul-eks-allow_nfs.id]
}

# data "aws_iam_policy_document" "policy" {
#   statement {
#     sid    = "ExampleStatement01"
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "elasticfilesystem:ClientMount",
#       "elasticfilesystem:ClientWrite",
#     ]

#     resources = [aws_efs_file_system.stw_node_efs.arn]

#     condition {
#       test     = "Bool"
#       variable = "aws:SecureTransport"
#       values   = ["true"]
#     }
#   }
# }

# resource "aws_efs_file_system_policy" "policy" {
#   file_system_id = aws_efs_file_system.stw_node_efs.id
#   policy         = data.aws_iam_policy_document.policy.json
# }
