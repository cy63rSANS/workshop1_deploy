#!/bin/bash
# SANSfire 2023 - Summer
# CloudAce Workshop
# Author: Cy63rSi (Simon Vernon)
# SANS 2023
#####################################################

# Phase 1 - Deployment

terraform init -input=false
rm -f terraform.tfstate 
rm -f terraform.tfstate.backup
#terraform plan -var-file=/tmp/$STUDENT/$RG/$STUDENT.tfvars -out=/tmp/$STUDENT/$RG/$STUDENT.$RG -input=false -compact-warnings
#terraform import -var-file=/tmp/$STUDENT/$RG/$STUDENT.tfvars azurerm_shared_image.STI_Kali_WS /subscriptions/0aa4e749-909f-4c6e-901f-1eef2978259a/resourceGroups/ImageMaster/providers/Microsoft.Compute/galleries/STI/images/STI_Kali_WS
#terraform plan -var-file=/tmp/$STUDENT/$RG/$STUDENT.tfvars -out=/tmp/$STUDENT/$RG/$STUDENT.$RG -input=false
terraform apply  -input=false

