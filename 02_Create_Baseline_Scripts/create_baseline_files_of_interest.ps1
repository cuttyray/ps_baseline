#Import Targets List
$targets = Import-Csv .\AllHosts.csv

#Import Configurations
$configs = Get-Content -Path .\configuration.json | ConvertFrom-Json


#Get Credentials from the Operator
#$creds = Get-Credential

#Set session options (This is required for out of band connections)
$so = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck

$targets | ForEach-Object {
Invoke-Command -ComputerName $targets.IP -Credential $creds -SessionOption $so -ArgumentList $configs.file_patterns {
    param ($filePatterns) 

    Get-ChildItem -Path C:\ -Recurse -File -Filter $filePatterns -Hidden -ErrorAction Continue } 
     
} |  Select-Object Name,FullName,CreationTime,PSComputerName | 
Export-Csv .\Baseline\File_Baseline.csv


