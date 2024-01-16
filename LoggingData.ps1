$tableParams = @'
{
    "properties": {
        "schema": {
               "name": "apacheAccess_CL",
               "columns": [
        {
                                "name": "SrcIP",
                                "type": "String"
                        },
                        {
                                "name": "TimeGenerated",
                                "type": "DateTime"
                        }, 
                       {
                                "name": "Method",
                                "type": "String"
                       },
                       {
                                "name": "HTTPcode",
                                "type": "String"
                        },
                        {
                                "name": "RawData",
                                "type": "String"
                        }
              ]
        }
    }
}
'@
Invoke-AzRestMethod -Path "/subscriptions/SUB/resourcegroups/SANSWorkshop/providers/microsoft.operationalinsights/workspaces/fairlinelogs/tables/apacheAccess_CL?api-version=2021-12-01-preview" -Method PUT -payload $tableParams