provider "azurerm" {
  features {}
}
#trraformfile_for_Kubernetes_Cluster
resource "azurerm_resource_group" "example" {
  name     = "CST8918-DevOps"
  location = "Canada Central"
}
 
resource "azurerm_kubernetes_cluster" "example" {
  name                = "kalpitcluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "kalpitcluster"
 
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    orchestrator_version = "latest"
    enable_auto_scaling = true
    min_count = 1
    max_count = 3
  }
 
  identity {
    type = "SystemAssigned"
  }
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}