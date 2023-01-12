
variable "instance_count" {}

resource "scaleway_instance_ip" "public_ips" {
	count= var.instance_count
	project_id = var.project_id
}

resource "scaleway_instance_server" "emqx" {
  count = var.instance_count
  name = "${local.team}-emqx${count.index}"

  project_id = var.project_id
  type       = "PRO2-XXS"
  image      = "ubuntu_jammy"

  tags = ["mqtt"]

  ip_id = scaleway_instance_ip.public_ips[count.index].id

  #additional_volume_ids = [scaleway_instance_volume.data.id]

  root_volume {
  	size_in_gb = 20
  }

  security_group_id = scaleway_instance_security_group.sg-www.id

  user_data = {
    name        = "initscript"
    cloud-init = file("${path.module}/deploy_emqx") 
}

}


resource "local_file" "instance_ips" {
	content = join("\n", flatten([ for i in scaleway_instance_server.emqx[*]: i.public_ip]))
	filename = "instance_ips"
}
