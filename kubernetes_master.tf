#### MASTER ####
resource "yandex_kubernetes_cluster" "k8s-zonal" {
  name = var.yandex_kubernetes_cluster_name
  cluster_ipv4_range  = var.cluster_ipv4_range
  service_ipv4_range  = var.service_ipv4_range
  network_id = yandex_vpc_network.my-zonal-net.id
  master {
    master_logging {
      audit_enabled              = false
      cluster_autoscaler_enabled = false
      enabled                    = false
      events_enabled             = false
      kube_apiserver_enabled     = false
    }

    public_ip = true
    zonal {
        zone      = yandex_vpc_subnet.mysubnet-a.zone
        subnet_id = yandex_vpc_subnet.mysubnet-a.id
    }
    security_group_ids = [yandex_vpc_security_group.k8s-zonal-sg.id]
  }
  service_account_id      = yandex_iam_service_account.service-account.id
  node_service_account_id = yandex_iam_service_account.service-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter,
    yandex_resourcemanager_folder_iam_member.logging-writer,
    yandex_vpc_subnet.mysubnet-a,
    yandex_vpc_network.my-zonal-net
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}
