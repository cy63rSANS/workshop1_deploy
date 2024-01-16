#!/bin/bash
# Workshop1 finalisation script - S.Vernon | SANS | CloudAce Workshop

storage=$(az storage account list -g SANSWorkshop | jq -r .[].name)
key=$(az storage account keys list -g SANSWorkshop -n $storage | jq -r .[0].value)
ip=$(az network public-ip list -g SANSWorkshop | jq -r .[].ipAddress)
sub=$(az account list | jq -r .[].id)

az network dns record-set a add-record -g core_platform -z fairline.world -n @ -a $ip --ttl 1

az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/IPADDR/$ip/g' /var/www/html/script.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/IPADDR/$ip/g' /var/www/html/index.html'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/ACCNAME/$storage/g' /nodeProject/api.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's@ACCKEY@$key@g' /nodeProject/api.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts '/nodeProject/start.sh &'

echo "Webserver Address = http://$ip"
echo "Storage Account = $storage"
echo "Storage Account Key = <best not to print these>"

echo "Updating LoggingData.ps1 with your subscription information"
sed -i s/SUB/$sub@g LoggingData.ps1