resource "aws_key_pair" "key" {
  key_name   = "nginx-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "master" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name

  tags = {
    Name = "master"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y ansible"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "target" {
  count         = 2
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.key.key_name

  tags = {
    Name = "target-${count.index + 1}"
  }
}