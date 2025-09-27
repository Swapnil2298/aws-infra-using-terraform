locals {
  region = "ap-south-1"
  name = "Swapnil-Project"
  cidr = "10.0.0.0/16"
  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  private_subnet_az_map = zipmap(local.azs,local.private_subnets)
  public_subnet_az_map = zipmap(local.azs,local.public_subnets)

  instance_type = "t2.micro"
  
}