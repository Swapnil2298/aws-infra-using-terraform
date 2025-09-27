resource "aws_internet_gateway" "Project-IGW" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = "${local.name}-Internet-Gateway"
  }
}
