resource "aws_security_group" "sample-lb-sg-01" {
  name        = "sample-lb-sg-01"
  description = "sample-lb-sg-01"
  vpc_id      = "${aws_vpc.sample-vpc-01.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sample-lb-sg-01"
  }
}

resource "aws_security_group" "sample-task-nginx-sg-01" {
  name        = "sample-task-nginx-sg-01"
  description = "sample-task-nginx-sg-01"
  vpc_id      = "${aws_vpc.sample-vpc-01.id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.sample-lb-sg-01.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sample-task-nginx-sg-01"
  }
}

resource "aws_security_group" "sample-task-laravel-sg-01" {
  name        = "sample-task-laravel-sg-01"
  description = "sample-task-laravel-sg-01"
  vpc_id      = "${aws_vpc.sample-vpc-01.id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.sample-task-nginx-sg-01.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sample-task-laravel-sg-01"
  }
}

resource "aws_security_group" "sample-db-sg-01" {
  name        = "sample-db-sg-01"
  description = "sample-db-sg-01"
  vpc_id      = "${aws_vpc.sample-vpc-01.id}"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = ["${aws_security_group.sample-task-laravel-sg-01.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "sample-db-sg-01"
  }
}
