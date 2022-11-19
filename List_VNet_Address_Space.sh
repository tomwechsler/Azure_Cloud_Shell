az network vnet list --query '[].{"Region": location, "vNet": name, "CIDR": addressSpace.addressPrefixes[0]}' --output table
