# IAM Role
resource "aws_iam_role" "sample-app-task-role" {
    name = "sample-app-task-role"
    path = "/"
    tags = {
      "Name" = "sample-app-task-role"
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

resource "aws_iam_role" "sample-app-task-execution-role" {
    name = "sample-app-task-execution-role"
    path = "/"
    tags = {
      "Name" = "sample-app-task-execution-role"
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
      "${aws_iam_role.sample-app-task-execution-role.name}",
    ]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy_attachment" "sample-s3-readonly-attach" {
    name       = "sample-s3-readonly-attach"
    roles      = [
      "${aws_iam_role.sample-app-task-role.name}",
    ]
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
