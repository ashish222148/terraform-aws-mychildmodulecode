/*
locals {
  cidr_block = "192.168.0.0/26"
}
*/
resource "aws_vpc" "ailiya" {
  cidr_block = var.cidr_block
}
data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_subnet" "ailiya-subnets" {
  vpc_id            = aws_vpc.ailiya.id
  for_each          = toset(data.aws_availability_zones.azs.names)
  availability_zone = each.value
  cidr_block        = cidrsubnet(var.cidr_block, 2, index(data.aws_availability_zones.azs.names, each.value))
}