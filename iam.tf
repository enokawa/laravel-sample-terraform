# IAM Role
resource "aws_iam_role" "sample-task-nginx-role" {
    name = "sample-task-nginx-role"
    path = "/"
    tags = {
      "Name" = "sample-task-nginx-role"
    }
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "sample-task-laravel-role" {
    name = "sample-task-laravel-role"
    path = "/"
    tags = {
      "Name" = "sample-task-laravel-role"
    }
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


# Attach Policy
resource "aws_iam_policy_attachment" "sample-taskexecution-attach" {
    name       = "sample-taskexecution-attach"
    roles      = [
      "${aws_iam_role.sample-task-nginx-role.name}",
      "${aws_iam_role.sample-task-laravel-role.name}",
    ]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
