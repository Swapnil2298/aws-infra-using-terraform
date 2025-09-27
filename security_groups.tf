##############################################
###### SECURITY GROUP FOR LOAD BALANCER ######
##############################################

resource "aws_security_group" "Project-Security-Group-ALB" {
  vpc_id = aws_vpc.Project-VPC.id
  name = "${local.name}-Security-Group-ALB"
  description = "Custom Security Group for ALB in Custom VPC"

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${local.name}-Security-Group-ALB"
  }
}

##############################################
## SECURITY GROUP FOR EC2 IN PRIVATE SUBNET ##
##############################################

resource "aws_security_group" "Project-Security-Group-EC2" {
  vpc_id = aws_vpc.Project-VPC.id
  name = "${local.name}-Security-Group-EC2"
  description = "Custom Security Group for EC2 in Private Subnet"

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
    security_groups = [aws_security_group.Project-Security-Group-ALB.id]
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
    security_groups = [aws_security_group.Project-Security-Group-Bastion-Host.id]
  }

  egress {
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${local.name}-Security-Group-EC2"
  }
}


#############################################
###### SECURITY GROUP FOR BASTION HOST ######
#############################################

resource "aws_security_group" "Project-Security-Group-Bastion-Host" {
  vpc_id = aws_vpc.Project-VPC.id
  name = "${local.name}-Security-Group-Bastion-Host"
  description = "Custom Security Group for Bastion Host in Custom VPC"

    ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${local.name}-Security-Group-Bastion-Host"
  }
}