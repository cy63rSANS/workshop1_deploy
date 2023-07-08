#!/bin/bash



storage=$(az storage account list -g CloudAce_Workshop | jq -r .[].name)
key=$(az storage account keys list -g CloudAce_Workshop -n $storage | jq -r .[0].value)
ip=$(az network public-ip list -g CloudAce_Workshop | jq -r .[].ipAddress)



az vm run-command invoke -g CloudAce_Workshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/IPADDR/$ip/g' /var/www/html/index.html'
az vm run-command invoke -g CloudAce_Workshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/ACCNAME/$storage/g' /nodeProject/search5.js'
az vm run-command invoke -g CloudAce_Workshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/ACCKEY/$key/g' /nodeProject/search5.js'
az vm run-command invoke -g CloudAce_Workshop -n Webserver --command-id RunShellScript --scripts 'node /nodeProject/search5'

echo "Address of the Webserver = http://$ip"
echo "Storage Account name = $storage"
echo "storage account key = <hidden>"