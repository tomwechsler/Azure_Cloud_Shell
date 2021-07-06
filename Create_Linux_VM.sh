#Login interactively and set a subscription to be the current active subscription
az login && az account set --subscription "Microsoft Azure Sponsorship"

az account show --output table

az account list --all --output table

#Let's create a Linux VM, starting off with creating a Resource Group.

#Create a resource group, then query the list of resource groups in our subscription
az group create \
    --name "twdemo21-rg" \
    --location "westeurope"

az group list -o table

#Create virtual network (vnet) and Subnet
az network vnet create \
    --resource-group "twdemo21-rg" \
    --name "twdemo21-vnet-1" \
    --address-prefix "172.16.0.0/16" \
    --subnet-name "twdemo21-subnet-1" \
    --subnet-prefix "172.16.1.0/24"

az network vnet list -o table

#Create public IP address
az network public-ip create \
    --resource-group "twdemo21-rg" \
    --name "twdemo21-linux-1-pip-1"

#Public IPs can take a few minutes to provision, we'll check on this after we provision the VM

#Create network security group
az network nsg create \
    --resource-group "twdemo21-rg" \
    --name "twdemo21-linux-nsg-1"

az network nsg list --output table

#Create a virtual network interface and associate with public IP address and NSG
az network nic create \
  --resource-group "twdemo21-rg" \
  --name "twdemo21-linux-1-nic-1" \
  --vnet-name "twdemo21-vnet-1" \
  --subnet "twdemo21-subnet-1" \
  --network-security-group "twdemo21-linux-nsg-1" \
  --public-ip-address "twdemo21-linux-1-pip-1"

az network nic list --output table

#Create a virtual machine
az vm create \
    --resource-group "twdemo21-rg" \
    --location "westeurope" \
    --name "twdemo21-linux-1" \
    --nics "twdemo21-linux-1-nic-1" \
    --image "rhel" \
    --admin-username "demoadmin" \
    --authentication-type "ssh" \
    --ssh-key-value ~/.ssh/id_rsa.pub 

#The VM may take a few minutes to create...let's bend spacetime.

az vm create --help | more 

#Open port 22 to allow SSH traffic to host
az vm open-port \
    --resource-group "twdemo21-rg" \
    --name "twdemo21-linux-1" \
    --port "22"

#Grab the public IP of the virtual machine
az vm list-ip-addresses --name "twdemo21-linux-1" --output table

ssh -l demoadmin w.x.y.z