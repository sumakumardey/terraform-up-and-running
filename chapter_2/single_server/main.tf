provider "aws" {
	region = "us-east-1"
}
variable "server_port" {
  description = "The port the server will use for http servers"
  default = 8080
}
resource "aws_security_group" "instance" {
 name = "terraform-example-instance"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "example"{
	ami = "ami-40d28157"
	instance_type = "t2.micro"
        vpc_security_group_ids = ["${aws_security_group.instance.id}"]
	tags {
	Name = "terraform-example"
	}
        user_data = <<-EOF
                    #!bin/bash
                    echo "Hello, World"> index.html
                    nohup busybox httpd -f -p "${var.server_port}" &
                  EOF
}

output "public_ip_instance" {
  value = "${aws_instance.example.public_ip}"
}
