# Repository
resource "aws_ecr_repository" "sample-nginx" {
  name = "sample/nginx"
  tags = {
    "Name" = "sample/nginx"
  }
}

resource "aws_ecr_repository" "sample-laravel" {
  name = "sample/laravel"
  tags = {
    "Name" = "sample/laravel"
  }
}
