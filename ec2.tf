resource "aws_instance" "web" {
  ami           = "ami-05552d2dcf89c9b24" # Change to your desired AMI ID
  instance_type = "t2.micro"             # Change to your desired instance type
  key_name      = "key"          # Change to your key pair name (optional)
  subnet_id     = aws_subnet.pub-subnet[count.index].id	 # Change to your subnet ID (if using a VPC)
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2
  
tags = {
    Name = "web-server"
}
provisioner "file" {
  source = "./key.pem"
  destination = "/home/ec2-user/key.pem"

  connection {
   type = "ssh"
   host = self.public_ip
   user = "ec2-user"
   private_key = "${file("./key.pem")}"
}
}
}
resource "aws_instance" "db" {
  ami           = "ami-05552d2dcf89c9b24" # Change to your desired AMI ID
  instance_type = "t2.micro"             # Change to your desired instance type
  key_name      = "key"          # Change to your key pair name (optional)
  subnet_id     = aws_subnet.pri-subnet.id        # Change to your subnet ID (if using a VPC)
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]
tags = {
    Name = "DB server"
} 
}
