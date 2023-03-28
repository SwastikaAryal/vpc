variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
    description = "cidr of sa_vpc"
 
}
variable "sa_publicsubnet" {
    type = string
    default = "10.0.1.0/24"
    description = "public subnet for instance"
  
}
variable "sa_privatesubnet" {
    type = string
    default = "10.0.2.0/24"
    description = "public subnet for instance"
  
}