# ##aws_eip needs to map to ec2 instance however for NAT no need to do this
# ##AWS will manage nat and only need to create aws_nat_gateway. 

# resource "aws_eip" "yt-eks-eip-ap-northeast-1a" {
#   instance = null
#   domain = "vpc"
#   tags = {
#     Name = "yt-eks-eip-ap-northeast-1a"
#   }
# }

# resource "aws_eip" "yt-eks-eip-ap-northeast-1c" {
#   instance = null
#   domain = "vpc"
#   tags = {
#     Name = "yt-eks-eip-ap-northeast-1c"
#   }
# }

# resource "aws_nat_gateway" "yt-eks-nat-ap-northeast-1a" {
#   allocation_id = aws_eip.yt-eks-eip-ap-northeast-1a.id
#   subnet_id     = aws_subnet.yt-eks-public-ap-northeast-1a.id

#   tags = {
#     Name = "yt-eks-nat-ap-northeast-1a"
#   }

#   depends_on = [aws_internet_gateway.yt-eks-igw]
# }

# resource "aws_nat_gateway" "yt-eks-nat-ap-northeast-1c" {
#   allocation_id = aws_eip.yt-eks-eip-ap-northeast-1c.id
#   subnet_id     =aws_subnet.yt-eks-public-ap-northeast-1c.id

#   tags = {
#     Name = "yt-eks-nat-ap-northeast-1c"
#   }

#   depends_on = [aws_internet_gateway.yt-eks-igw]
# }


