# SANS Cloud Workshop - SANSFIRE 2023
## Workbook and lab content
#### Simon Vernon, SANS 2023


[Link to Instructions document](https://ws1clsansfire.blob.core.windows.net/documents/Workshop1.pdf)

### Prerequisites
1. An Azure account that you have full admistrative ownership of and isnt running any production workloads
2. A web broswer

If you have been assigned an Azure account by SANS for a course this is fine to use for this workshop. 
If you have an Azure account already, you can use this but be aware you will be hosting a vulnerable web application created by the workshop code.
If you need to register a new Azure account, you can create a Pay-As-You-Go Azure subscription from [here:](https://azure.microsoft.com/en-gb/pricing/purchase-options/pay-as-you-go/?srcurl=https%3A%2F%2Fazure.microsoft.com%2Ffree)  
#### A valid email address and credit card are required to subscribe to Microsoft Azure.

You are liable for any expenses associated with hosting objects and services within your azure account.  
For this workshop, the costs will be less than $5.
A full teardown script is provided at the end of the workshop to delete all assets created.
Steps to delete subscriptions at the end are also provided.


### Getting started

1. Log into Azure and open a cloud shell
2. clone this repository using:
    `git clone https://github.com/cy63rSANS/workshop1_deploy`
3. Execute terraform init and terraform apply:
    `terraform init`
    `terraform apply`
4. Check out the new assets in the resource group "SANSWorkshop", click on the virtual machine called 'Webserver1' and finds its public IP address. 
5. Browse to the Public IP, you should have a web site online (wait a few minutes if you don't)
6. now execute the final build script back in your Azure shell. 
    `./final.sh`
7. You are now ready to start hardening the platform, follow the instructions in the document linked above.


#### Contact Simon Vernon
#### @Xzer0f
#### https://www.linkedin.com/in/simon-vernon