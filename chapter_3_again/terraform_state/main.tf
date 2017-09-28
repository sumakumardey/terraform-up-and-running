terraform {
 backend "s3" {
  bucket = "terraform-up-and-running-suman"
  key = "chapter_3_again/terraform_state/terraform.tfstate"
  region = "us-east-1"
 }
}

data "terraform_remote_state" "network"{
  backend = "s3"
  config {
    bucket = "terraform-up-and-running-suman"
    key = "chapter_3_again/terraform_state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"
}
