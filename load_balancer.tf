##############################################
##### APPLICATION LOAD BALANCER CREATION #####
##############################################

resource "aws_lb" "Project-ALB" {
    name = "${local.name}-ALB"
    load_balancer_type = "application"
    internal = false
    security_groups = [aws_security_group.Project-Security-Group-ALB.id]
    subnets = [for subnet in aws_subnet.Project-Public-Subnets : subnet.id]

    tags = {
      Name = "${local.name}-ALB"
    }
}

###############################################
##### LOAD BALANCER TARGET GROUP CREATION #####
###############################################

resource "aws_lb_target_group" "Project-ALB-Target-Group" {
    name = "${local.name}-ALB-Target-Group"
    vpc_id = aws_vpc.Project-VPC.id
    port = 80
    protocol = "HTTP"

    health_check {
      path = "/"
      protocol = "HTTP"
      interval = 10
      healthy_threshold = 5
      unhealthy_threshold = 2
    }

    tags = {
      Name = "${local.name}-ALB-Target-Group"
    }
  
}

#############################################
###### LOAD BALANCER LISTENER CREATION ######
#############################################

resource "aws_lb_listener" "Project-ALB-Listener" {
  load_balancer_arn = aws_lb.Project-ALB.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.Project-ALB-Target-Group.arn
  }
  
}