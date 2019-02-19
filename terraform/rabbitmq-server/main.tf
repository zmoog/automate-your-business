// https://www.terraform.io/docs/providers/aws/index.html
// https://github.com/terraform-providers

provider "aws" {
  version = "1.59"
  region  = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "zmoog-automate-your-business-infr"
    key    = "rabbitmq-server/terraform.tfstate"
    region = "eu-west-1"
  }
}

//
// VPC — Virtual Private Cloud (https://aws.amazon.com/vpc/)
//

data "aws_vpc" "default" {
  default = true
}

// Subnets — https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html
data "aws_subnet" "default" {
  default_for_az    = true
  availability_zone = "eu-west-1a"
}

// 
// Amazon EC2 — Elastic Compute Cloud (https://aws.amazon.com/ec2/)
//

// https://www.terraform.io/docs/providers/aws/d/ami.html
data "aws_ami" "server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS ENA 1901_01-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # CentOS
}

// https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "rabbitmq" {
  ami           = "${data.aws_ami.server.id}"
  instance_type = "t2.micro"

  subnet_id                   = "${data.aws_subnet.default.id}"
  key_name                    = "${var.project}"
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]
  associate_public_ip_address = true

  tags = {
    Name        = "rabbitmq-server-${terraform.workspace}"
    Project     = "${var.project}"
    Environment = "${terraform.workspace}"
  }
}

// https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "security_group" {
  name        = "${var.project}-${terraform.workspace}-sg"
  description = "Security group for ASG that allows traffic to the EC2 instances"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.project}-${terraform.workspace}-sg"
    environment = "${terraform.workspace}"
    application = "${var.project}"
  }
}
