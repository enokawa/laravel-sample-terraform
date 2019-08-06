# VPC
resource "aws_vpc" "sample-vpc-01" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags = {
        "Name" = "sample-vpc-01"
    }
}


# Subnet
resource "aws_subnet" "sample-public-a" {
    vpc_id ="${aws_vpc.sample-vpc-01.id}"
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "ap-northeast-1a"
    map_public_ip_on_launch = true

    tags = {
        "Name" = "sample-public-a"
    }
}

resource "aws_subnet" "sample-public-c" {
    vpc_id ="${aws_vpc.sample-vpc-01.id}"
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "ap-northeast-1c"
    map_public_ip_on_launch = true

    tags = {
        "Name" = "sample-public-c"
    }
}

resource "aws_subnet" "sample-app-a" {
    vpc_id ="${aws_vpc.sample-vpc-01.id}"
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "ap-northeast-1a"
    map_public_ip_on_launch = false

    tags = {
        "Name" = "sample-app-a"
    }
}

resource "aws_subnet" "sample-app-c" {
    vpc_id ="${aws_vpc.sample-vpc-01.id}"
    cidr_block              = "10.0.3.0/24"
    availability_zone       = "ap-northeast-1c"
    map_public_ip_on_launch = false

    tags = {
        "Name" = "sample-app-c"
    }
}

resource "aws_subnet" "sample-private-a" {
    vpc_id ="${aws_vpc.sample-vpc-01.id}"
    cidr_block              = "10.0.4.0/24"
    availability_zone       = "ap-northeast-1a"
    map_public_ip_on_launch = false

    tags = {
        "Name" = "sample-private-a"
    }
}

resource "aws_subnet" "sample-private-c" {
    vpc_id ="${aws_vpc.sample-vpc-01.id}"
    cidr_block              = "10.0.5.0/24"
    availability_zone       = "ap-northeast-1c"
    map_public_ip_on_launch = false

    tags = {
        "Name" = "sample-private-c"
    }
}
