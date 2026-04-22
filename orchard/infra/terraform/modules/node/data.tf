data "ct_config" "node" {
  content = templatefile("${path.module}/butane.tftpl", {
    ssh_public_key     = var.ssh_public_key
    hostname           = var.hostname
    fedora_version     = var.fedora_version
    kubernetes_version = var.kubernetes_version
    cni_version        = var.cni_version
    crictl_version     = var.crictl_version
    install_kubectl    = var.install_kubectl
  })
  strict       = true
  pretty_print = false
}