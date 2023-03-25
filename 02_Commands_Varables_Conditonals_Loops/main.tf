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
  # Configuration options
}

locals {
  mytag = "bekir-local-name"
}

resource "aws_instance" "tf-ec2" {
  ami             = var.ec2_ami # "ami-0ed9277fb7eb570c9"
  instance_type   = var.ec2_type
  key_name        = var.key_name
  security_groups = ["ssh-http-dvpc"]
  tags = {
    #"Name" = "${var.ec2_name}-instance" #"tf-ec2"
    Name = "${local.mytag}-come-from-local"
  }
}

resource "aws_s3_bucket" "tf-s3" {
  #bucket = "${var.s3_bucket_name}-${count.index}"
  #otomatik index olusturur her ekledigimizde count 1 artacak #"bekir-tf-bucket2"
  force_destroy = true
  #count         = var.num_of_buckets
  #count = var.num_of_buckets != 0 ? var.num_of_buckets : 3
  #num_of_buckets 0dan farkliysa var.num_of_bucketsin default degeri kadar bucket olustur
  #0a esit degilse 3 tane olustur
  for_each = toset(var.users)
  bucket   = "example-tf-s3-bucket-bekir-${each.value}"

  tags = {
    "Name" = "${local.mytag}-come-from-locals"
  }
}

resource "aws_iam_user" "new_user" {
  for_each = toset(var.users)
  name     = each.value

  tags = {
    tag-key = "tag-value"
  }
}

