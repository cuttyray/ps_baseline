$targets = Import-Csv .\AllHosts.csv |
    #Where-Object {$_.os -eq "Win10"} |
    Select-Object -ExpandProperty ip

Invoke-Command -CN $targets -CR $creds {
Get-CimInstance -ClassName Win32_UserAccount } |
    Select-Object -Property Name, AccountType, Disabled, PasswordRequired, SID, PSComputerName |
    Export-Csv .\Baseline\AccountsBaseline.csv -Force -NoTypeInformation

   