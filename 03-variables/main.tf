resource "aws_instance" "amazon_linux_2" {
  for_each      = data.aws_subnet_ids.all.ids
  ami           = data.aws_ami.amazon_linux_2.id
  subnet_id     = each.value
  instance_type = "t3.small"
  user_data = templatefile("${path.module}/templates/init.tpl", {})
  tags = {
    Environment = var.environment
  }
}

