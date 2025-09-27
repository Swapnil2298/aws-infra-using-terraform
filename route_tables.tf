##############################################
### ROUTE TABLE CREATION FOR PUBLIC SUBNET ###
##############################################

resource "aws_route_table" "Project-Public-Route_table" {
  vpc_id = aws_vpc.Project-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project-IGW.id
  }

  tags = {
    Name = "${local.name}-route-table"
  }
}

#############################################
# ROUTE TABLE ASSOCIATION FOR PUBLIC SUBNET #
#############################################

resource "aws_route_table_association" "Project-Route_table_assoc" {
  for_each = aws_subnet.Project-Public-Subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.Project-Public-Route_table.id
  
}