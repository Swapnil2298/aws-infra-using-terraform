##############################################
############# CUSTOM VPC CREATION ############
##############################################

resource "aws_vpc" "Project-VPC" {
  region = local.region
  cidr_block = local.cidr

  tags = {
    Name = "${local.name}-VPC"
  }
  
}


##############################################
###### PUBLIC SUBNETS CREATION (2 AZs) #######
##############################################

resource "aws_subnet" "Project-Public-Subnets" {
  for_each =  local.public_subnet_az_map

  vpc_id = aws_vpc.Project-VPC.id
  cidr_block = each.value
  availability_zone = each.key

  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name}-Public-Subnet-${each.key}"
  }
}


##############################################
###### PRIVATE SUBNETS CREATION (2 AZs) ######
##############################################

resource "aws_subnet" "Project-Private-Subnets" {
  for_each =  local.private_subnet_az_map

  vpc_id = aws_vpc.Project-VPC.id
  cidr_block = each.value
  availability_zone = each.key

  tags = {
    Name = "${local.name}-Private-Subnet-${each.key}"
  }
}
