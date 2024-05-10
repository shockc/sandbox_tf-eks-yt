# resource "aws_internet_gateway" "yt-eks-igw" {
#   vpc_id = aws_vpc.yt-eks-vpc.id

#   tags = {
#     Name = "yt-eks-igw"
#   }
# }