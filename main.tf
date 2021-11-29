data "azurerm_resource_group" "rg" {
  name = "juan-baas"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
/*data "azurerm_kubernetes_cluster" "example" {
  name                = "teamthree-k8s"
  resource_group_name = data.azurerm_resource_group.rg.name
}


provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.example.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.example.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.example.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.example.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.example.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.example.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.example.kube_config.0.cluster_ca_certificate)
}*/

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.87.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "juan-baas"
    storage_account_name = "storagejuanbaas"
    container_name       = "juanbaas"
    key                  = "fstate"
  }
}



module "acr" {
  source              = "./modules/acr"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

module "aks" {
  source              = "./modules/aks"
  prefix              = var.prefix
  location            = var.location
  client_id           = var.client_id
  client_secret       = var.client_secret
  node_count          = var.node_count
  vm_size             = var.vm_size
  os_disk_size_gb     = var.os_disk_size_gb
  resource_group_name = data.azurerm_resource_group.rg.name
}

/*module "helm" {
  source              = "./modules/helm"
  prefix              = var.prefix
  location            = var.location
  client_id           = var.client_id
  client_secret       = var.client_secret
  node_count          = var.node_count
  resource_group_name = data.azurerm_resource_group.rg.name
}*/

module "load_balancer" {
  source               = "./modules/load_balancer"
  public_ip_address_id = module.public_ip.id
  location             = var.location
  prefix               = var.prefix
  resource_group_name  = data.azurerm_resource_group.rg.name
}

module "public_ip" {
  source              = "./modules/public_ip"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}
