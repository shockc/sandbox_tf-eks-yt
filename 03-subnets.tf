# resource "aws_subnet" "yt-eks-private-ap-northeast-1a" {
#   vpc_id            = aws_vpc.yt-eks-vpc.id
#   # cidr_block        = "10.0.0.0/19"
#   cidr_block        = "10.167.80.0/24"
#   availability_zone = "ap-northeast-1a"

#   tags = {
#     "Name"                            = "yt-eks-private-ap-northeast-1a"
#     "kubernetes.io/role/internal-elb" = "1"
#     "kubernetes.io/cluster/demo"      = "owned"
#   }
# }

# resource "aws_subnet" "yt-eks-private-ap-northeast-1c" {
#   vpc_id            = aws_vpc.yt-eks-vpc.id
#   # cidr_block        = "10.0.32.0/19"
#   cidr_block        = "10.167.81.0/24"
#   availability_zone = "ap-northeast-1c"

#   tags = {
#     "Name"                            = "yt-eks-private-ap-northeast-1c"
#     "kubernetes.io/role/internal-elb" = "1"
#     "kubernetes.io/cluster/demo"      = "owned"
#   }
# }

# resource "aws_subnet" "yt-eks-public-ap-northeast-1a" {
#   vpc_id                  = aws_vpc.yt-eks-vpc.id
#   # cidr_block              = "10.0.64.0/19"
#   cidr_block        = "10.167.82.0/24"
#   availability_zone       = "ap-northeast-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     "Name"                       = "yt-eks-public-ap-northeast-1a"
#     "kubernetes.io/role/elb"     = "1"
#     "kubernetes.io/cluster/demo" = "owned"
#   }
# }

# resource "aws_subnet" "yt-eks-public-ap-northeast-1c" {
#   vpc_id                  = aws_vpc.yt-eks-vpc.id
#   # cidr_block              = "10.0.96.0/19"
#   cidr_block        = "10.167.83.0/24"
#   availability_zone       = "ap-northeast-1c"
#   map_public_ip_on_launch = true

#   tags = {
#     "Name"                       = "yt-eks-public-ap-northeast-1c"
#     "kubernetes.io/role/elb"     = "1"
#     "kubernetes.io/cluster/demo" = "owned"
#   }
# }