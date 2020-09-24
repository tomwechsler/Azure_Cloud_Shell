az login

az account show

az account list --all --output table

az account set --subscription "MSDN Platforms"

#Count Azure resources
az graph query -q "Resources | summarize count()"

#Count key vault resources
az graph query -q "Resources | where type =~ 'microsoft.keyvault/vaults' | count"

#List resources sorted by name
az graph query -q "Resources | project name, type, location | order by name asc"

az graph query -q "Resources | project name, type, location | order by name asc" --output table

#Show all virtual machines ordered by name in descending order
az graph query -q "Resources | project name, location, type| where type =~ 'Microsoft.Compute/virtualMachines' | order by name desc"

az graph query -q "Resources | project name, location, type| where type =~ 'Microsoft.Compute/virtualMachines' | order by name desc" --output table

#Show first five virtual machines by name and their OS type
az graph query -q "Resources | where type =~ 'Microsoft.Compute/virtualMachines' | project name, properties.storageProfile.osDisk.osType | top 5 by name desc"

az graph query -q "Resources | where type =~ 'Microsoft.Compute/virtualMachines' | project name, properties.storageProfile.osDisk.osType | top 5 by name desc" --output table

#Count virtual machines by OS type
az graph query -q "Resources | where type =~ 'Microsoft.Compute/virtualMachines' | summarize count() by tostring(properties.storageProfile.osDisk.osType)"

az graph query -q "Resources | where type =~ 'Microsoft.Compute/virtualMachines' | summarize count() by tostring(properties.storageProfile.osDisk.osType)" --output table

#Show resources that contain storage
az graph query -q "Resources | where type contains 'storage' | distinct type"

#List all public IP addresses
az graph query -q "Resources | where type contains 'publicIPAddresses' and isnotempty(properties.ipAddress) | project properties.ipAddress | limit 100"

#Count resources that have IP addresses configured by subscription
az graph query -q "Resources | where type contains 'publicIPAddresses' and isnotempty(properties.ipAddress) | summarize count () by subscriptionId"

#List resources with a specific tag value
az graph query -q "Resources | where tags.Projekt=~'Cloud2020' | project name"

az graph query -q "Resources | where tags.Projekt=~'Cloud2020' | project name, tags"

#List all storage accounts with specific tag value
az graph query -q "Resources | where type =~ 'Microsoft.Storage/storageAccounts' | where tags['tag with a space']=='costcenter'" #no result

#Show aliases for a virtual machine resource
az graph query -q "Resources | where type =~ 'Microsoft.Compute/virtualMachines' | limit 1 | project aliases"

#Show distinct values for a specific alias
az graph query -q "Resources | where type=~'Microsoft.Compute/virtualMachines' | extend alias = aliases['Microsoft.Compute/virtualMachines/storageProfile.osDisk.managedDisk.storageAccountType'] | distinct tostring(alias)" #no result

#Show unassociated network security groups
az graph query -q "Resources | where type =~ 'microsoft.network/networksecuritygroups' and isnull(properties.networkInterfaces) and isnull(properties.subnets) | project name, resourceGroup | sort by name asc" #no result