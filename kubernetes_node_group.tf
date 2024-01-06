#### WORKER ####
resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = yandex_kubernetes_cluster.k8s-zonal.id
  name        = "node"
  description = "description"

  instance_template {
    platform_id = "standard-v2"

    container_runtime {
      type = "containerd"
    }

    network_interface {
      nat                = var.kuber_node.external_ip
      subnet_ids         = [yandex_vpc_subnet.mysubnet-a.id]
    }

    resources {
      memory = var.kuber_node.memory
      cores  = var.kuber_node.cores
      core_fraction = var.kuber_node.core_fraction
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    metadata = {
      ssh-keys= var.ssh_keys 
    }
  }

  scale_policy {
    fixed_scale {
      size = var.kuber_node.count
    }
  }

  allocation_policy {
    location {
      zone = var.kuber_node.zone
    }
  }
}
