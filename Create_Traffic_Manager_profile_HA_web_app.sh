az login

az account show

az account list --all --output table

az account set --subscription "MSDN Platforms"

#Create a resource group
az group create --name myResourceGroup --location westeurope

#Create a Traffic Manager profile
az network traffic-manager profile create --name twtmpcloud2020 --resource-group myResourceGroup --routing-method Priority --path "/" --protocol HTTP --unique-dns-name twtmpcloud2020 --ttl 30 --port 80

#Create web app service plans
az appservice plan create --name twwebappeastus --resource-group myResourceGroup --location eastus --sku S1

az appservice plan create --name twwebappwesteurope --resource-group myResourceGroup --location westeurope --sku S1

#Create a web app in the app service plan
az webapp create --name twapp1eastus --plan twwebappeastus --resource-group myResourceGroup

az webapp create --name twapp2westeurope --plan twwebappwesteurope --resource-group myResourceGroup

#Add Traffic Manager endpoints (East US endpoint)
az webapp show --name twapp1eastus --resource-group myResourceGroup --query id #Make note of ID displayed

az network traffic-manager endpoint create --name twapp1eastus --resource-group myResourceGroup --profile-name twtmpcloud2020 --type azureEndpoints --target-resource-id <ID from az webapp show> --priority 1 --endpoint-status Enabled

#Add Traffic Manager endpoints (West Europe endpoint)
az webapp show --name twapp2westeurope --resource-group myResourceGroup --query id #Make note of ID displayed

az network traffic-manager endpoint create --name twapp2westeurope --resource-group myResourceGroup --profile-name twtmpcloud2020 --type azureEndpoints --target-resource-id <ID from az webapp show> --priority 2 --endpoint-status Enabled

#Test your Traffic Manager profile (Determine the DNS name)
az network traffic-manager profile show --name twtmpcloud2020 --resource-group myResourceGroup --query dnsConfig.fqdn

#In the Portal modify the text in one azure app

#Copy the DNS name of your Traffic Manager profile (http://twtmpcloud2020.trafficmanager.net.trafficmanager.net) to view the website in a new web browser session

#To view Traffic Manager failover in action
az network traffic-manager endpoint update --name twapp1eastus --resource-group myResourceGroup --profile-name twtmpcloud2020 --type azureEndpoints --endpoint-status Disabled

#Copy the DNS name of your Traffic Manager profile (http://<relativednsname>.trafficmanager.net) to view the website in a new web browser session

#Clean up resources
az group delete --resource-group myResourceGroup