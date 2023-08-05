#!/bin/bash
# Workshop1 finalisation script - S.Vernon | SANS | CloudAce Workshop

storage=$(az storage account list -g SANSWorkshop | jq -r .[].name)
key=$(az storage account keys list -g SANSWorkshop -n $storage | jq -r .[0].value)
ip=$(az network public-ip list -g SANSWorkshop | jq -r .[].ipAddress)

az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/IPADDR/$ip/g' /var/www/html/script.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/IPADDR/$ip/g' /var/www/html/index.html'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/ACCNAME/$storage/g' /nodeProject/api.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's@ACCKEY@$key@g' /nodeProject/api.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts '/nodeProject/start.sh &'

echo "Webserver Address = http://$ip"
echo "Storage Account = $storage"
echo "Storage Account Key = <best not to print these>"