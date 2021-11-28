prefix               = "teamthree"
resource_group_name  = "juan-baas"
location             = "CentralUS"
node_count           = 3                # Min 3 nodes recommended for production
vm_size              = "Standard_D2_v2" 
os_disk_size_gb      = 30
container_name       = "juanbaas"
storage_account_name = "storagejuanbaas"