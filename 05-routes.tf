# resource "aws_route_table" "yt-eks-private1" {
#   vpc_id = aws_vpc.yt-eks-vpc.id

#   route {
#       cidr_block                 = "0.0.0.0/0"
#       nat_gateway_id             = aws_nat_gateway.yt-eks-nat-ap-northeast-1a.id

#     }
#   tags = {
#     Name = "yt-eks-private-nat-ap-northeast-1a"
#   }
# }

# resource "aws_route_table" "yt-eks-private2" {
#   vpc_id = aws_vpc.yt-eks-vpc.id

#   route {
#       cidr_block                 = "0.0.0.0/0"
#       nat_gateway_id             = aws_nat_gateway.yt-eks-nat-ap-northeast-1c.id

#     }
#   tags = {
#     Name = "yt-eks-private-nat-ap-northeast-1c"
#   }
# }


# resource "aws_route_table" "yt-eks-public" {
#   vpc_id = aws_vpc.yt-eks-vpc.id

#   route {
#       cidr_block                 = "0.0.0.0/0"
#       gateway_id                 = aws_internet_gateway.yt-eks-igw.id

#     }


#   tags = {
#     Name = "yt-eks-public"
#   }
# }

# resource "aws_route_table_association" "yt-eks-private-ap-northeast-1a" {
#   subnet_id      = aws_subnet.yt-eks-private-ap-northeast-1a.id
#   route_table_id = aws_route_table.yt-eks-private1.id
# }

# resource "aws_route_table_association" "yt-eks-private-ap-northeast-1c" {
#   subnet_id      = aws_subnet.yt-eks-private-ap-northeast-1c.id
#   route_table_id = aws_route_table.yt-eks-private2.id
# }

# resource "aws_route_table_association" "yt-eks-public-ap-northeast-1a" {
#   subnet_id      = aws_subnet.yt-eks-public-ap-northeast-1a.id
#   route_table_id = aws_route_table.yt-eks-public.id
# }

# resource "aws_route_table_association" "yt-eks-public-ap-northeast-1c" {
#   subnet_id      = aws_subnet.yt-eks-public-ap-northeast-1c.id
#   route_table_id = aws_route_table.yt-eks-public.id
# }