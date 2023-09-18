variable "instancias" {
  description = "Nombre de instancias"
  type        = set(string)
  #type        = list(string)
  default = ["mysql"]
}

resource "aws_instance" "public_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.SG_Public_Instance.id]
  user_data              = file("scripts/userdata.sh")
  for_each               = var.instancias
  #for_each              = toset(var.instancias)

  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}


resource "aws_instance" "monitoring_instance" {
  count                  = var.enable_monitoring == 1 ? 1 : 0
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.SG_Public_Instance.id]
  user_data              = file("scripts/userdata.sh")


  tags = {
    "Name" = "Monitoreo-${local.sufix}"
  }
}


















