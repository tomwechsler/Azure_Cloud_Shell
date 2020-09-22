az login

az account show

az account list --all --output table

az account set --subscription "MSDN Platforms"

# Add the Resource Graph extension to the Azure CLI environment
az extension add --name resource-graph

# Check the extension list (note that you may have other extensions installed)
az extension list

# Run help for graph query options
az graph query -h

# Login first with az login if not using Cloud Shell

# Run Azure Resource Graph query
az graph query -q 'Resources | project name, type | limit 5'

# Run Azure Resource Graph query with 'order by'
az graph query -q 'Resources | project name, type | limit 5 | order by name asc'

# Run Azure Resource Graph query with `order by` first, then with `limit`
az graph query -q 'Resources | project name, type | order by name asc | limit 5'

# Remove the Resource Graph extension from the Azure CLI environment
az extension remove -n resource-graph