# SANS Cloud Workshop - SANSFIRE 2023
## Workbook and lab content
#### Simon Vernon, SANS 2023


[Link to Instructions document](https://ws1clsansfire.blob.core.windows.net/documents/Workshop1.pdf)

### Prerequisites
1. An Azure account that you have full admistrative ownership of and isnt running any production workloads
2. A web broswer

### Getting started

1. Log into Azure and open a cloud shell
2. clone this repository
    `git clone https://github.com/cy63rSANS/workshop1_deploy`
3. Execute terraform init and terraform apply
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