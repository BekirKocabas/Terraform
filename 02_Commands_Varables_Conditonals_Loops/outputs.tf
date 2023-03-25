output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.tf-ec2.public_ip
}

# output "bucket_region" {
#   value = aws_s3_bucket.tf-s3[*]
# }

output "instance_privat_ip" {
  value = aws_instance.tf-ec2.private_ip
}

output "uppercase_users" {
  value = [for user in var.users : upper(user) if length(user) > 6]

}