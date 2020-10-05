az login

az account show

az account list --all --output table

az account set --subscription "MSDN Platforms"

#Create a resource group
az group create --name "myResourceGroup" -l "westeurope"

#Create a key vault
az keyvault create --name "twkvdemo2020" --resource-group "myResourceGroup" --location "westeurope"

#Add a secret to Key Vault
az keyvault secret set --vault-name "twkvdemo2020" --name "ExamplePassword" --value "hVFkk965BuUv"

#View the value contained in the secret as plain text
az keyvault secret show --name "ExamplePassword" --vault-name "twkvdemo2020"

#To view your keys
az keyvault secret list --vault-name "twkvdemo2020"

#Create access policy
az keyvault set-policy --name "twkvdemo2020" --upn "jwest@tomwechsler.ch" --secret-permissions get, list

#Enable Key Vault for deployment
az keyvault update --name "twkvdemo2020" --resource-group "myResourceGroup" --enabled-for-deployment "true"

#Enable Key Vault for disk encryption
az keyvault update --name "twkvdemo2020" --resource-group "myResourceGroup" --enabled-for-disk-encryption "true"

#Enable Key Vault for template deployment
az keyvault update --name "twkvdemo2020" --resource-group "myResourceGroup" --enabled-for-template-deployment "true"

#Clean up resources
az group delete --name myResourceGroup --yes