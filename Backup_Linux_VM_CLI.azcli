#Please open the cloud shell (from the Azure portal) or:
shell.azure.com

#Switch to PowerShell if not already selected

az account show

az account list --all --output table

az account set --subscription "your subscription"

$recoveryServicesVaultName = "twvault2020"
$resourceGroupName = "tw-demo-2020"
$virtualMachineName = "twlinuxvm02"
$location = "westeurope"
$adminName = "azureadmin"

#Create the Resource Group
az group create --name $resourceGroupName --location $location

#Create a Virtual Machine
az vm create --resource-group $resourceGroupName --name $virtualMachineName --image UbuntuLTS --admin-username $adminName --generate-ssh-keys

#open up port 80 (optional)
az vm open-port --port 80 --resource-group $resourceGroupName --name $virtualMachineName

#get public IP (optional)
az vm show --resource-group $resourceGroupName --name $virtualMachineName -d --query [publicIps] 

#login to VM (optional)
ssh azureadmin@publicIpAddress

#update packages (optional)
sudo apt-get -y update

#install NGINX (optional)
sudo apt-get -y install nginx

#create recovery vault
az backup vault create --resource-group $resourceGroupName --name $recoveryServicesVaultName --location $location

# enable backup with the default policy (we have no custom policy)
az backup protection enable-for-vm --resource-group $resourceGroupName --vault-name $recoveryServicesVaultName --vm $virtualMachineName --policy-name DefaultPolicy

# initial backup
az backup protection backup-now --resource-group $resourceGroupName --vault-name $recoveryServicesVaultName --container-name $virtualMachineName --item-name $virtualMachineName --retain-until 18-10-2020 --backup-management-type AzureIaasVM

# watch backup
az backup job list --resource-group $resourceGroupName --vault-name $recoveryServicesVaultName --output table
