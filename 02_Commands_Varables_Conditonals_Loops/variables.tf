variable "ec2_name" {
  default = "bekir-ec2"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  default = "ami-0742b4e673072066f"
}

variable "key_name" {
  default = "" #keypair ohne .pem
}

variable "s3_bucket_name" {
  #default = "bekir-new-s3-variable-bucket2"
}

variable "num_of_buckets" {
  default = 2
}

variable "users" {
  default = ["santino", "michael", "fredo"]
}

