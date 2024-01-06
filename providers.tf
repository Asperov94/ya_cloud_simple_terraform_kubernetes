terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "=0.104.0"
    }
  }
  required_version = ">= 1.6.6"
  backend "s3" {
    access_key     = var.access_key
    secret_key     = var.secret_key
    bucket         = "asperov"
    key            = "terraform.tfstate"
    region         = "ru-central1-a"
    endpoint       = "https://storage.yandexcloud.net"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # This option is required to describe backend for Terraform version 1.6.1 or higher.
    skip_s3_checksum            = true # This option is required to describe backend for Terraform version 1.6.3 or higher.
  }
}

provider "yandex" {
  service_account_key_file = "ya_key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone = "ru-central1-a"
}

