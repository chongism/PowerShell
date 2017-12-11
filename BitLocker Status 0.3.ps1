$LogLocation = "C:\Windows\BitLocker Status Log.txt"

Write-Output "***Bitlocker Encryption has started***" | Out-File $LogLocation

while ($BitLocker -ne 100){

    $BitLocker = (Get-BitLockerVolume | where -Property EncryptionPercentage).EncryptionPercentage
    $ReportDate = Get-Date
    $ReportDate = $ReportDate.ToString('dd/MM/yyyy hh:mm:ss') 
    $Status = "Bitlocker Encryption Status $BitLocker%"

    Start-Sleep -seconds 1

    Write-Output $ReportDate

    $ReportDate | Out-File $LogLocation
    $Status | Out-File $LogLocation
}

Write-Output "BitLocker encryption completed at $Time" | Out-File $LogLocation

[System.Windows.MessageBox]::Show('BitLocker Encryption Complete!')