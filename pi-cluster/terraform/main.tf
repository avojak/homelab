module "server" {
  source = "./modules/node"

  providers = {
    esxi = esxi.esx_rpi_01
  }

  guest_name = "eks-server.${var.root_domain}"
  memsize    = 7
  numvcpus   = 4

  inventory_group = "server"
}

module "agent_01" {
  source = "./modules/node"

  providers = {
    esxi = esxi.esx_rpi_02
  }

  guest_name = "eks-agent-01.${var.root_domain}"
  memsize    = 7
  numvcpus   = 4

  inventory_group = "agents"
}

module "agent_02" {
  source = "./modules/node"

  providers = {
    esxi = esxi.esx_rpi_03
  }

  guest_name = "eks-agent-02.${var.root_domain}"
  memsize    = 3
  numvcpus   = 4

  inventory_group = "agents"
}

resource "ansible_host" "esx_rpi_host" {
  for_each = local.esxi_hosts

  name   = each.value.hostname
  groups = ["esxi"]

  variables = {
    ansible_user = "root"
    ansible_host = each.value.ip_address
  }
}
