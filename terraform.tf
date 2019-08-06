terraform {
  required_version  = "0.12.6"
  backend "s3" {
    bucket = "laravel-sample-terraform-tfstate"
    key    = "ap-northeast-1/sample/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
