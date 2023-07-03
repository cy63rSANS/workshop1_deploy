#!/bin/bash
# SANSfire 2023 - Summer
# CloudAce Workshop
# Author: Cy63rSi (Simon Vernon)
# SANS 2023
#####################################################


while getopts ":s:e:l:" opt; do
        case $opt in
	s )
            # Student
            STUDENT=$OPTARG
            ;;
    e )
            # Event
            RG=$OPTARG
            ;;
    l )
            # Location
            LOC=$OPTARG
            ;;
    : )
            echo "$OPTARG Needs an argument"
            usage
            exit 1
            ;;
    esac
done

function usage () {
  echo "
        ########################################################################################################################
        -s : Student ID
        -l : Location - Must match the tfvars file
        -e : Sets Resource Group
        ########################################################################################################################
        
        OR
        user $ ./deploy.sh -e Dev-0003 -s vernon -l ukwest
"
  exit 1
}

if [[ -z $STUDENT ]]; then
    usage
    exit 1
fi

if [[ -z $RG ]]; then
    usage
    exit 1
fi

if [[ -z $LOC ]]; then
    usage
    exit 1
fi

# Convert DNS address to lowercase
rg="${RG,,}"
student="${STUDENT,,}"

# DEBUG
echo "The Resource Group (EVENT ID) is: $RG"
echo "The Event Location is: $LOC"
echo "Student ID is: $STUDENT"
echo "NoVNC URL will be: $student.sti.jupiter-rockets.com"

RGEXIST=`az group exists --name $RG`
    if [[ $RGEXIST == "true" ]]
        then echo "Group name already exists, Exiting!"
        #read -p "Press enter to continue"
        exit
	else 
    echo "Continuing..."
fi
#########################################
# Staging code - REMOVE FROM PRODUCTION

#read -p "Press enter to continue"

#########################################


rm -rf /tmp/$STUDENT
mkdir /tmp/$STUDENT
mkdir /tmp/$STUDENT/$RG
cp template.tfvars /tmp/$STUDENT/$RG/$STUDENT.tfvars


# Update Variables in Config.tfvars
    sed -i s/VARLOC/"${LOC}"/g /tmp/"$STUDENT"/"$RG"/"$STUDENT".tfvars
    sed -i s/VARRG/"${RG}"/g /tmp/"$STUDENT"/"$RG"/"$STUDENT".tfvars
    sed -i s/VARDNS1/"${student}"/g /tmp/"$STUDENT"/"$RG"/"$STUDENT".tfvars
    sed -i s/VARDNS2/"${student}".STI/g /tmp/"$STUDENT"/"$RG"/"$STUDENT".tfvars
    sed -i s/VAREVT/"${STUDENT}"/g /tmp/"$STUDENT"/"$RG"/"$STUDENT".tfvars

#################################################################

# Phase 1 - Deployment

terraform init -input=false
rm -f terraform.tfstate 
rm -f terraform.tfstate.backup
terraform plan -var-file=/tmp/$STUDENT/$RG/$STUDENT.tfvars -out=/tmp/$STUDENT/$RG/$STUDENT.$RG -input=false -compact-warnings
#terraform import -var-file=/tmp/$STUDENT/$RG/$STUDENT.tfvars azurerm_shared_image.STI_Kali_WS /subscriptions/0aa4e749-909f-4c6e-901f-1eef2978259a/resourceGroups/ImageMaster/providers/Microsoft.Compute/galleries/STI/images/STI_Kali_WS
#terraform plan -var-file=/tmp/$STUDENT/$RG/$STUDENT.tfvars -out=/tmp/$STUDENT/$RG/$STUDENT.$RG -input=false
terraform apply  -input=false /tmp/$STUDENT/$RG/$STUDENT.$RG

# Phase 2  - VM Deployment

declare -a arr1=("CareerWS"
                 "DMZ-WEB"
                 "DMZ-SMTP"
                 "DMZ-DNS"
                 "Server1"
                 "Workstation1"
                 )

for i in "${arr1[@]}"
do
    az vm create --no-wait --resource-group $RG --name $i --public-ip-address "" --nics $i --os-disk-name $i --image /subscriptions/0ca097b8-df5d-406b-8155-a4c896584838/resourceGroups/Core_Platform/providers/Microsoft.Compute/galleries/STI/images/$i --specialized --authentication-type password --admin-user netadmin --admin-password Itys.c0mItys.c0m
done

az network dns record-set cname set-record --cname $student.$LOC.cloudapp.azure.com  --resource-group Core_Platform --zone-name sti.jupiter-rockets.com -n $student
az vm run-command invoke  --command-id RunPowerShellScript --name $i -g $RG --scripts 'netsh advfirewall set allprofiles state off'
echo "###################################"
echo "Deployment Complete"
az vm list -g $RG -d -o table
echo "###################################"