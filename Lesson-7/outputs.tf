output "webserver_instance_id" {
  value = aws_instance.my_webserver.id
}

output "webserver_public_ip_adress" {
  value = aws_eip.my_static_ip.public_ip
}

output "webserver_sg_id" {
  value = aws_security_group.my-webserver.id
}

output "webserver_sg_arm" {
  value       = aws_security_group.my-webserver.arn
  description = "This is security group ARN"
}
