$targets = Import-Csv .\AllHosts.csv |
  #Where-Object {$_.os -eq "Win10"} |
    Select-Object -ExpandProperty ip

$targets | ForEach-Object{
Invoke-Command -CN $targets -CR $creds {

Get-WmiObject -Class Win32_StartupCommand }
} |
Select-Object Command,User,UserSID,Location,PSComputerName |
Export-Csv .\Baseline\AutorunsBaseline.csv 