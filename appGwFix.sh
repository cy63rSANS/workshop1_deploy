#!/bin/bash
# Workshop1 app gateway IP fix script - S.Vernon | SANS | CloudAce Workshop

ip=$(az network public-ip show -n PIP-Webserver --resource-group SANSWorkshop | jq .ipAddress -r)
ip1=$(az network public-ip show -n appGWpip --resource-group SANSWorkshop | jq .ipAddress -r)
az network dns record-set a delete -g core_platform -z fairline.world -n @ --yes
az network dns record-set a add-record -g core_platform -z fairline.world -n @ -a $ip1 --ttl 1

az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/$ip/$ip1/g' /var/www/html/script.js'
az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/$ip/$ip1/g' /var/www/html/index.html'

echo "New Webserver Address = http://$ip1"
