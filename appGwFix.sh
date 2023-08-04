#!/bin/bash
# Workshop1 app gateway IP fix script - S.Vernon | SANS | CloudAce Workshop

ip=$(az network public-ip list -g SANSWorkshop | jq -r .[0].ipAddress)
ip1=$(az network public-ip list -g SANSWorkshop | jq -r .[1].ipAddress)


az vm run-command invoke -g SANSWorkshop -n Webserver --command-id RunShellScript --scripts 'sed -i 's/$ip/$ip1/g' /var/www/html/sript.js'

echo "New Webserver Address = http://$ip1"
