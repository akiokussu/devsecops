
# I will use this later after creation for the Ansible automation
# terraform output -json > ../ansible-aws-devsecops/ansible_inventory.json

output "web_app_instance_private_ip" {
  value = aws_instance.web_app_instance.private_ip
  description = "Private IP of the Web Application Server"
}

output "jenkins_instance_private_ip" {
  value = aws_instance.jenkins_instance.private_ip
  description = "Private IP of the Jenkins Server"
}

output "nginx_instance_public_ip" {
  value = aws_instance.nginx_instance.public_ip
  description = "Public IP of the Nginx Server"
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
  description = "Public IP of the Bastion Host"
}
