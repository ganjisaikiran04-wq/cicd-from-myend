
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
	cidr_block           = "10.0.0.0/16"
	enable_dns_support   = true
	enable_dns_hostnames = true
	tags = {
		Name = "main-vpc"
	}
}
# resource "aws_internet_gateway" "igw" {
# 	vpc_id = aws_vpc.main.id
# 	tags = { Name = "main-igw" }
# }

# # Create 2 public subnets (one per AZ)
# resource "aws_subnet" "public" {
# 	count                   = 2
# 	vpc_id                  = aws_vpc.main.id
# 	cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
# 	availability_zone       = data.aws_availability_zones.available.names[count.index]
# 	map_public_ip_on_launch = true
# 	tags = {
# 		Name = "public-${count.index + 1}"
# 	}
# }

# resource "aws_route_table" "public_rt" {
# 	vpc_id = aws_vpc.main.id
# 	route {
# 		cidr_block = "0.0.0.0/0"
# 		gateway_id = aws_internet_gateway.igw.id
# 	}
# 	tags = { Name = "public-rt" }
# }

# resource "aws_route_table_association" "public_assoc" {
# 	count          = 2
# 	subnet_id      = aws_subnet.public[count.index].id
# 	route_table_id = aws_route_table.public_rt.id
# }

# # Create 2 NAT Gateways (one in each public subnet) for private subnet egress
# resource "aws_eip" "nat_eip" {
# 	count = 2
# }

# resource "aws_nat_gateway" "nat" {
# 	count         = 2
# 	allocation_id = aws_eip.nat_eip[count.index].id
# 	subnet_id     = aws_subnet.public[count.index].id
# 	tags = { Name = "nat-${count.index + 1}" }
# }

# # Create 4 private subnets distributed across AZs (2 per AZ)
# resource "aws_subnet" "private" {
# 	count             = 4
# 	vpc_id            = aws_vpc.main.id
# 	cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 10 + count.index)
# 	availability_zone = data.aws_availability_zones.available.names[count.index % 2]
# 	map_public_ip_on_launch = false
# 	tags = {
# 		Name = "private-${count.index + 1}"
# 	}
# }

# # Route tables for private subnets, each pointing to a NAT Gateway in same AZ
# resource "aws_route_table" "private_rt" {
# 	count  = 2
# 	vpc_id = aws_vpc.main.id
# 	route {
# 		cidr_block     = "0.0.0.0/0"
# 		nat_gateway_id = aws_nat_gateway.nat[count.index].id
# 	}
# 	tags = { Name = "private-rt-${count.index + 1}" }
# }

# resource "aws_route_table_association" "private_assoc" {
# 	count          = 4
# 	subnet_id      = aws_subnet.private[count.index].id
# 	route_table_id = aws_route_table.private_rt[count.index % 2].id
# }

