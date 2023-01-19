resource "scaleway_instance_ip" "public_ips" {
  count = 4	  
  project_id = var.project_id
}

resource "scaleway_instance_server" "emqx" {
  count = 4
  name = "${local.team}-emqx${count.index}"
 
  project_id = var.project_id
  type       = "PRO2-XXS"
  image      = "ubuntu_jammy"

  tags = ["mqtt"]  
  ip_id = scaleway_instance_ip.public_ips[count.index].id

  root_volume {
    size_in_gb = 20
  }

  security_group_id = scaleway_instance_security_group.sg-www.id

  user_data = {
    name        = "initscript"
    cloud-init = file("${path.module}/init-instance")
  }

}

output "emqx0_ip" {
  value = "http://${scaleway_instance_server.emqx[0].public_ip}:18083"
}

output "emqx1_ip" {
  value = "http://${scaleway_instance_server.emqx[1].public_ip}:18083"
}

output "emqx2_ip" {
  value = "http://${scaleway_instance_server.emqx[2].public_ip}:18083"
}

output "emqx3_ip" {
  value = "http://${scaleway_instance_server.emqx[3].public_ip}:18083"
}
