########### INSERT BUILD VERSION TO REGISTRY ############
#
# Author: Max Chong
# Company: ASOS
# Date: 08/12/17
# Version: 0.3 
#
#########################################################


# Define COM object

$TSEnv = New-Object -ComObject Microsoft.SMS.TSEnvironment

# Retrieve Package Name (TS Build name)

$TSName = $TSEnv.Value("_SMSTSPackageName")
$WIMImage = $TSEnv.Value("OSDImageName")
$WinOS = (Get-WmiObject -class Win32_OperatingSystem).Caption
$OSVersion = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ReleaseId).ReleaseId
$BuiltOn = get-date -Format "dd/MM/yy"

# Set Registry Entry

Push-Location
Set-Location HKLM:

# Check if path key already exists. If location does not exist, create entry and write to the registry key.
# Else, output 

$PathCheck = Test-Path .\SYSTEM\TSVer

if ($PathCheck -eq $false)
    {
 
        New-Item -Path .\SYSTEM -Name TSVer
        New-ItemProperty -Path .\SYSTEM\TSVer -Name "TSName" -PropertyType "String" -Value $TSName
        New-ItemProperty -Path .\SYSTEM\TSVer -Name "WIMImage" -PropertyType "String" -Value $WIMImage
        New-ItemProperty -Path .\SYSTEM\TSVer -Name "WinOS" -PropertyType "String" -Value $WinOS
        New-ItemProperty -Path .\SYSTEM\TSVer -Name "OSVersion" -PropertyType "String" -Value $OSVersion
        New-ItemProperty -Path .\SYSTEM\TSVer -Name "BuiltOn" -PropertyType "String" -Value $BuiltOn
        Pop-Location

        cls

        ######## Test Output #######
        
        <#
        echo "Build version entered successfully!"
        echo "Task Sequence Name: $TSName"
        echo "WIM Image: $WIMImage"
        echo "Windows Version: $WinOS"
        echo "Version: $OSVersion"
        echo "Built on: $BuiltOn"
        #>

    } else {
        cls
        echo "Entry already exists!"
    }


######################## END ##########################