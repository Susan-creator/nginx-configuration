
output "master_ip" {
  value = aws_instance.master.public_ip
}

output "target_ips" {
  value = aws_instance.target[*].public_ip
}