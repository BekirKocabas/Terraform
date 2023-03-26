terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
  backend "s3" {
    bucket = "tf-remote-s3-bucket-bekir"
    key = "env/dev/tf-remote-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-s3-app-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}

locals {
  mytag = "bekir-local-name"
}

variable "ec2_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "" #key-pair ohne .pem

}

data "aws_ami" "tf_ami" {
  most_recent = true
  owners      = ["amazon", "self"] #["self"] ich suche AMI, die gehört mir
  #burada hem amazonda hem kendi amilerimizde aratiyoruz

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
    #devaminda güncellenme tarihi var. yukarda most recent 
    # yazdigi icin en güncelini aldi
    # ["my-terraform*"] #kendi hesabimizdan alinca: 
    # hesabimdaki ami isimkerine göre yaziyorum 
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_instance" "tf-ec2" {
  ami = data.aws_ami.tf_ami.id
  #data "aws_ami" "tf_ami" yukarda datanin yaninda yazan kismi aldim teranklari kaldirdim 
  #ve aralara nokta koydum- sonda da yanina .id ile belirttim
  instance_type = var.ec2_type
  key_name      = var.key_name

  tags = {
    Name = "${local.mytag}-ubuntu-from-aws" #oncesinde kendi amilerimizden secmistik

  }
}
resource "aws_s3_bucket" "tf-test-1" {
  bucket = "bekir-test-1-versioning"
}

resource "aws_s3_bucket" "tf-test-2" {
  bucket = "bekir-test-2-versioning"
}
output "iam_info" {
  value = data.aws_ami.tf_ami.id

}