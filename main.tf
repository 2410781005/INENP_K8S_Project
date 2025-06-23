locals {
  zone = "de-fra-1"
}

resource "exoscale_sks_cluster" "my_sks_cluster" {
  zone = local.zone
  name = var.exoscale_cluster_name
  exoscale_csi = true
  service_level = var.exoscale_sks_service_level
}

resource "exoscale_security_group" "web_sg" {
  name = "web-access"
  zone = local.zone
}

resource "exoscale_security_group_rule" "http_ingress" {
  security_group_id = exoscale_security_group.web_sg.id
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 80
  end_port          = 80
  cidr              = "0.0.0.0/0"
  description       = "Allow HTTP traffic"
  zone = local.zone
}

resource "exoscale_sks_nodepool" "my_sks_nodepool" {
  cluster_id         = exoscale_sks_cluster.my_sks_cluster.id
  zone               = exoscale_sks_cluster.my_sks_cluster.zone
  name               = "${var.exoscale_cluster_name}-nodepool"
  instance_type      = "standard.large"
  size               = 1

  security_group_ids = [
    exoscale_security_group.web_sg.id
  ]
}

resource "exoscale_sks_kubeconfig" "my_sks_kubeconfig" {
  cluster_id = exoscale_sks_cluster.my_sks_cluster.id
  zone       = exoscale_sks_cluster.my_sks_cluster.zone

  user   = "kubernetes-admin"
  groups = ["system:masters"]
}

resource "local_sensitive_file" "kubeconfig" {
    filename = "./kubeconfig"
    content = exoscale_sks_kubeconfig.my_sks_kubeconfig.kubeconfig
}
