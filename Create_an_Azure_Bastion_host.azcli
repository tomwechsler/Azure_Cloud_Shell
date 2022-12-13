az login

az account show

az account list --all --output table

az account set --subscription "MSDN Platforms"

#Create a resource group
az group create --name "myResourceGroup" --location "westeurope"

#Create a virtual network and an Azure Bastion subnet
az network vnet create --resource-group MyResourceGroup --name MyVnet --address-prefix 10.0.0.0/16 --subnet-name AzureBastionSubnet --subnet-prefix 10.0.0.0/24 --location westeurope

#Create a public IP address for Azure Bastion
az network public-ip create --resource-group MyResourceGroup --name MyIp --sku Standard --location westeurope

#Create a new Azure Bastion resource in the AzureBastionSubnet of your virtual network
#It takes about 5 minutes for the Bastion resource to create and deploy
az network bastion create --name MyBastion --public-ip-address MyIp --resource-group MyResourceGroup --vnet-name MyVnet --location westeurope

