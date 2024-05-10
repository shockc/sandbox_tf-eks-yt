
# # resource "aws_security_group" "eks_security_group-ops" {
# #   name        = "eks-security-group-ops-test"
# #   description = "Allow traffic from EC2 to EKS control plane"
# #   vpc_id      = aws_vpc.ops_vpc.id
  
# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# # }
  

# #   ingress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     ###associates the security group of the Amazon EKS cluster's control plane with the EC2 instance
# #     security_groups = [aws_eks_cluster.demo.vpc_config[0].cluster_security_group_id]
# #   }
# # }


# resource "aws_security_group" "yt-eks-ssh_security_group" {
#   name        = "yt-eks-ssh-security-group"
#   description = "Allow SSH traffic"
#   vpc_id      = aws_vpc.yt-eks-vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed for your source IP range
#   }
#     egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_iam_role" "yt-eks-ssm_role" {
#   name = "yt-eks-ssm-instance-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com",
#         },
#       },
#     ],
#   })
# }

# resource "aws_iam_role_policy_attachment" "yt-eks-ssm_policy_attachment_ec2" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.yt-eks-ssm_role.name
# }

# resource "aws_iam_instance_profile" "yt-eks-ssm" {
#   name = "yt-eks-profile"
#   role = aws_iam_role.yt-eks-ssm_role.name
# }

# data "aws_ami" "ami_linux" {
#   most_recent = true
#   owners = [ "amazon" ]
#   filter {
#     name = "description"
#     # values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-09-19"]
#     # values = ["Amazon Linux 2023 AMI 2023.3.20240122.0 x86_64 HVM kernel-6.1"]
#     values = ["Amazon Linux 2023 AMI 2023.3.20240312.0 x86_64 HVM kernel-6.1"]
#   }
# }

# resource "aws_instance" "eks_instance_yt-eks-CR" {
#   ami           = data.aws_ami.ami_linux.id
#   instance_type = "t2.micro"
#    # Attach IAM role to the EC2 instance
#   iam_instance_profile = aws_iam_instance_profile.yt-eks-ssm.name 
#   ##Need to create first the key-pair in aws and download it. here it's cy_ops
#   key_name      = "yt-eks-key"    
#   subnet_id     = aws_subnet.yt-eks-public-ap-northeast-1a.id
#   ##FOr This ec2 to connect to EKS need to manually add into the EKS SecGroup auto created by AWS
#   vpc_security_group_ids = [aws_security_group.yt-eks-ssh_security_group.id]
  
#   user_data = <<-EOF
#     #!/bin/ba  
    
#     # Install kubectl
#     curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/linux/amd64/kubectl
#     chmod +x ./kubectl
#     mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
    
#     # Add kubectl to the user's path
#     echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
#     EOF


#   tags = {
#     Name = "yt-eks-CR"
#   }
# }

# # ##for ec2 publicIP, no need as OpS CR will use SSM
# # resource "aws_eip" "example_eip" {
# #   instance = aws_instance.eks_instance_Ops_CR.id
# # }



