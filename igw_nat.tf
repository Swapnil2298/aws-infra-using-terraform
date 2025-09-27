resource "aws_internet_gateway" "Project-IGW" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = "${local.name}-Internet-Gateway"
  }
}

/*
resource "aws_nat_gateway" "Project-NAT" {
  
  subnet_id = ""

  tags = {
    Name = "${local.name}-NAT-Gateway"
  }
}
*/