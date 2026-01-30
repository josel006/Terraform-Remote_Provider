# This lab demonstrates how we can use remote provisioners to excute code on an EC2 instance after creating it

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_instance" "myec2" {
  ami                         = "ami-0532be01f26a3de55"
  associate_public_ip_address = true
  availability_zone           = "us-east-1c"
  instance_type               = "t2.micro"
  key_name                    = "New_Key_Pair"
  vpc_security_group_ids      = ["sg-01c94c30f55598259"]

  connection {
    type        = "ssh"      # ssh or winrm
    user        = "ec2-user" # the ssh user to use for the connection
    private_key = file("C:/Users/josel/Downloads/New_Key_Pair.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y httpd",
      "sudo systemctl enable --now httpd",
      "echo '<h1>Hello World from '$(hostname -f)'</h1>' | sudo tee /var/www/html/index.html"
    ]
  }

}





# you can pass the user data script to remote exec using
#   provisioner "remote-exec" {
#   # script = "${path.module}/script.sh"
#     script = "./script.sh"
#  }


# you can use the following to pass the user date instead of exec-provisioner
# user_data = file("${path.module}/script.sh")


