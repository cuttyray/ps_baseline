$targets = Import-Csv .\AllHosts.csv |
<#  Where-Object {$_.os -eq "Win10"} |#>
    Select-Object -ExpandProperty ip

ICM -CN $targets -CR $creds -FilePath .\01_Reference_Scripts\firewalls.ps1 | 
Select-Object LocalAddress,InstanceID,RemotePort,Direction,RemoteAddress,LocalPort,Protocol,Action,PSComputerName |
Export-Csv .\Baseline\FirewallsBaseline.csv
