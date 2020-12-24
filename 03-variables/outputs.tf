output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "subnet_ids" {
  value = data.aws_subnet_ids.all.ids
}

output "ami_id" {
  value = data.aws_ami.amazon_linux_2.id
}

output "instance_public_ips" {
  value = [
    for instance in aws_instance.amazon_linux_2 :
    instance.public_ip
  ]
}

output "instance_ids" {
  value = [
    for instance in aws_instance.amazon_linux_2 :
    instance.id
  ]
}

output "instance_subnets_public_ips_map" {
  value = {
    for instance in aws_instance.amazon_linux_2 :
    instance.subnet_id => instance.public_ip
  }
}
