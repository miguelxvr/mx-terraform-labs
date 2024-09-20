resource "aws_instance" "example" {
  ami           = "ami-0142b530ec8935389" 
  instance_type = "t2.small"

  tags = {
    Name = "terraform-example-instance"
  }
}