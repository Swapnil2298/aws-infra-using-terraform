output "Project-VPC-ID" {
  value = aws_vpc.Project-VPC.id
}

output "Project-Public-Subnet-ID" {
  value = [for pubsub in aws_subnet.Project-Public-Subnets : pubsub.id]
}

output "Project-Private-Subnet-ID" {
  value = [for pvtsub in aws_subnet.Project-Private-Subnets : pvtsub.id]
}

output "Project-Public-Route_table-ID" {
  value = aws_route_table.Project-Public-Route_table.id
}

output "Project-ALB-DNS-Name" {
  value = aws_lb.Project-ALB.dns_name
}
