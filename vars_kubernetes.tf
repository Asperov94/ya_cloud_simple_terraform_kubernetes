
variable "ssh_keys" {
  default = var.ssh_key 
}

variable "cloud_id" {
  description = "ID of a Yandex Cloud"
  default = var.cloud_id
}

variable "folder_id" {
  description = "ID of a folder inside a Yandex Cloud"
  default = var.folder_id
}

variable "yandex_kubernetes_cluster_name" {
    default = "k8s-zonal"
}

variable "yandex_kubernetes_cluster_public_ip" {
    default = false
}
variable "cluster_ipv4_range" {
    default = "172.17.0.0/16"
}

variable "service_ipv4_range"{
    default = "172.18.0.0/16"
}

variable "yandex_vpc_subnet-a"{
    default = "10.205.0.0/16"
}

variable "kuber_node" {
  type = object({
    count  = number,
    cores  = number,
    memory = number,
    core_fraction = number,
    hdd = number,
    zone = string
    external_ip = bool,
  })
  default = {
    count  = 1,
    cores  = 2,
    memory = 1,
    core_fraction = 5,
    hdd = 64,
    zone = "ru-central1-a",
    external_ip = false
  }
}

