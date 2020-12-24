resource "aws_security_group" "allow_http" {
  name   = "allow-http-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow-http-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "amazon_linux_2" {
  for_each               = data.aws_subnet_ids.all.ids
  ami                    = data.aws_ami.amazon_linux_2.id
  subnet_id              = each.value
  instance_type          = "t3.small"
  user_data              = templatefile("${path.module}/templates/init.tpl", {})
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  iam_instance_profile   = aws_iam_instance_profile.workload_instance_profile.name
  tags = {
    Environment = var.environment
  }
}

