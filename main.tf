resource "aws_instance" "instance" {
  count         = 5
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-03f7da9ebe210e12a"]
  tags = {
    Name = "${var.components[count.index]}-dev"
  }
}

resource "aws_route53_record" "dns" {
  count  =  5
  zone_id = "Z03351562OJATKDWYEO40"
  name    = "${var.components[count.index]}-dev"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[count.index].public_ip]
}

variable "components" {
  default = [ "frontend","postgresql", "auth-service","portfolio-service","analytics-service" ]
}




