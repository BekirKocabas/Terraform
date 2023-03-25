terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
  # Configuration options
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name = "" #ohne pem
  security_groups = ["ssh-http-dvpc"] #tanimli security gruplardan biri
  tags = {
    "Name" = "created-by-tf"
  }
}

resource "aws_s3_bucket" "tf-s3" {
    bucket = "bekir-tf-bucket"
  
}