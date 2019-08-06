# Aurora Cluster
resource "aws_rds_cluster" "sample-db-01" {
  engine                          = "aurora-mysql"
  cluster_identifier              = "sample-db-01"
  availability_zones              = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  master_username                 = "dbuser"
  master_password                 = "dbuserpasswd"
  db_subnet_group_name            = "${aws_db_subnet_group.sample-db-subnet-group.name}"
  db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.sample-db-pg-cluster.name}"
  vpc_security_group_ids          = ["${aws_security_group.sample-db-sg-01.id}"]
  port                            = "3306"
  backup_retention_period         = 1
  preferred_backup_window         = "20:00-20:30"
  preferred_maintenance_window    = "sun:21:00-sun:21:30"
  tags = {
    "Name" = "sample-db-01"
  }
}


# Cluster Instance
resource "aws_rds_cluster_instance" "sample-db-01-01" {
  engine                       = "aurora-mysql"
  identifier                   = "sample-db-01-01"
  cluster_identifier           = "${aws_rds_cluster.sample-db-01.id}"
  instance_class               = "db.t3.small"
  db_subnet_group_name         = "${aws_db_subnet_group.sample-db-subnet-group.name}"
  db_parameter_group_name      = "${aws_db_parameter_group.sample-db-pg-instance.name}"
  preferred_maintenance_window = "mon:21:00-mon:21:30"
  publicly_accessible          = false
  auto_minor_version_upgrade   = false

  tags = {
    "Name" = "sample-db-01-01"
  }
}


# Subnet Group
resource "aws_db_subnet_group" "sample-db-subnet-group" {
    name        = "sample-db-subnet-group"
    description = "sample-db-subnet-group"
    subnet_ids  = ["${aws_subnet.sample-private-a.id}", "${aws_subnet.sample-private-c.id}"]
}


# Cluster Parameter
resource "aws_rds_cluster_parameter_group" "sample-db-pg-cluster" {
    name        = "sample-db-pg-cluster"
    family      = "aurora-mysql5.7"
    description = "sample-db-pg-cluster"

    parameter {
      name  = "character_set_client"
      value = "utf8mb4"
    }
    parameter {
      name  = "character_set_connection"
      value = "utf8mb4"
    }
    parameter {
      name  = "character_set_database"
      value = "utf8mb4"
    }
    parameter {
      name  = "character_set_filesystem"
      value = "utf8mb4"
    }
    parameter {
      name  = "character_set_results"
      value = "utf8mb4"
    }
    parameter {
      name  = "character_set_server"
      value = "utf8mb4"
    }
    parameter {
      name  = "collation_connection"
      value = "utf8mb4_general_ci"
    }
    parameter {
      name  = "time_zone"
      value = "Asia/Tokyo"
    }
}


# Cluster DB Instance Parameter
resource "aws_db_parameter_group" "sample-db-pg-instance" {
    name        = "sample-db-pg-instance"
    family      = "aurora-mysql5.7"
    description = "sample-db-pg-instance"

    parameter {
      name  = "long_query_time"
      value = 1
    }
    parameter {
      name  = "slow_query_log"
      value = 1
    }
    parameter {
      name  = "log_output"
      value = "FILE"
    }
}
