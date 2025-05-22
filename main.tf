provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0afc7fe9be84307e4" # Example Amazon Linux 2 AMI (update as needed)
  instance_type = "t2.micro"

  # Ensure it's created in a specific AZ or leave it dynamic
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "ExampleInstance"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.example.availability_zone
  size              = 1
  type              = "gp3"

  tags = {
    Name = "1GB-EBS-Volume"
  }
}

resource "aws_volume_attachment" "example_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.example.id
}
