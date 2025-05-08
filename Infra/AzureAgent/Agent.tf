resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/my-key-pair.pub")  # Local public key to use for EC2 instance
}

resource "aws_instance" "AzureAgent" {
  ami           = "ami-084568db4383264d4"  # Example Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key.key_name
  
  associate_public_ip_address = true  
  subnet_id            = aws_subnet.Zone1.id
  security_groups      = [aws_security_group.eks_sg.id]

  tags = {
    Name = "AzureAgent"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip } ansible_user=ubuntu ansible_ssh_private_key_file=/home/abdallah/.ssh/my-key-pair > ~/Project/Agent.inv "
  }
}
