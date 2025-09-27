##############################################
########## LAUNCH TEMPLATE CREATION ##########
##############################################

resource "aws_launch_template" "Project-Launch-Template" {
  name = "${local.name}-Launch-Template"
  instance_type = local.instance_type
  image_id = "ami-01b6d88af12965bb6"
  key_name = "mumbaikeypair"
  user_data = filebase64("install_httpd.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.Project-Security-Group-EC2.id]
    
  }

  tags = {
    Name = "${local.name}-Launch-Template"
  }
}


#############################################
######## AUTO SCALING GROUP CREATION ########
#############################################

resource "aws_autoscaling_group" "Project-Auto-Scaling-Group" {
  desired_capacity = 2
  min_size = 2
  max_size = 3

  vpc_zone_identifier = [for subnet in aws_subnet.Project-Public-Subnets : subnet.id]
  target_group_arns = [aws_lb_target_group.Project-ALB-Target-Group.arn]

  launch_template {
    id = aws_launch_template.Project-Launch-Template.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = "Web-Server"
    propagate_at_launch = true
  }

}