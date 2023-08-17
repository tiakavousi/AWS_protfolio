output "subnets" {
  value = [aws_subnet.private-a.id, aws_subnet.private-b.id,
  aws_subnet.public-a.id, aws_subnet.public-b.id]
}

output "public_subnet_id" {
  value = aws_subnet.public-a.id
}

output "subnet_group_public_ids" {
  value = [aws_subnet.public-a.id, aws_subnet.public-b.id]
}

output "subnet_group_private_ids" {
  value = [aws_subnet.private-a.id, aws_subnet.private-b.id]
}