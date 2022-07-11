locals {
  tags = {
    Demo           = 1
    Bucket_purpose = "use module "
  }
}

module "s3" {
  source         = "git@github.com:TechPechu/Tp-Tf-modules.git//modules/s3"
  s3_bucket_name = "tp-999991112222"
  tags           = local.tags
}

output "s3_id" {
    value = module.s3.s3.id
  
}

resource "aws_s3_bucket" "import_s3" {
  bucket = "tp-1234567891"
  tags = {
    Environment = "Dev-1"
    Name        = "My bucket"
  }
}


module "sg" {
  source         = "git@github.com:TechPechu/Tp-Tf-modules.git//modules/sg"
  sg_name        = "sg_demo"
  sg_description = "for ec2"
  ingress_variable = [{
    description     = "for"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    ipv4_list       = ["103.92.100.131/32", "183.82.29.107/32"]
    ipv6_list       = []
    prefix_list_ids = []
    security_groups = []
    self            = false
  }]
  tags = local.tags
}


module "ec2" {
  source            = "git@github.com:TechPechu/Tp-Tf-modules.git//modules/ec2"
  tags              = local.tags
  ami_id            = "ami-0ca285d4c2cda3300"
  ec2_sg_ids        = [module.sg.sg_id]
  availability_zone = "us-west-2a"

}

module "ec2_testing" {
  source            = "git@github.com:TechPechu/Tp-Tf-modules.git//modules/ec2"
  tags              = local.tags
  ami_id            = "ami-0ca285d4c2cda3300"
  ec2_sg_ids        = [module.sg.sg_id]
  availability_zone = "us-west-2a"


}
