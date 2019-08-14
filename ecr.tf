# Repository
resource "aws_ecr_repository" "sample-nginx" {
  name = "sample/nginx"
  tags = {
    "Name" = "sample/nginx"
  }
}

resource "aws_ecr_repository" "sample-php-fpm" {
  name = "sample/php-fpm"
  tags = {
    "Name" = "sample/php-fpm"
  }
}
