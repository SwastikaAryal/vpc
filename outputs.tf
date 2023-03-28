output "vpc_id"{
    value = aws_vpc.sa_vpc.id
}
output "public_subnet" {
  value = aws_subnet.sa_publicsubnet.id
}
output "private_subnet" {
  value = aws_subnet.sa_privatesubnet.id
}
