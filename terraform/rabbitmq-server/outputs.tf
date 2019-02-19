output "public_dns" {
  value = "${aws_instance.rabbitmq.public_dns}"
}
