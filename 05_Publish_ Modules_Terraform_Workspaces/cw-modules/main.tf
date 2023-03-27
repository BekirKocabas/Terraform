provider "aws" {
  region = "us-east-1"
}

module "docker_instance" {
    source = "BekirKocabas/docker-instance/aws"
    key_name = "" #your key name
}