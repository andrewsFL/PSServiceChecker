$servicesFilePath = ".\services.csv"
$servicesList = Import-Csv -Path $servicesFilePath -Delimiter ','

$fromEmail = "youremail@outlook.com" # Change to email address used to send the alert
$toEmail = "youremail@outlook.com" # Change to your email address
$smtpServer = "smtp.office365.com" # Change to your SMTP server
$smtpPort = 587 # Change to your SMTP port

$credential = Import-CliXml -Path ".\emailcred.xml"
$sendAlert = $false

<#
    Run the following inside the project directory to create emailcred.xml file for your email credentials.

    $credential = Get-Credential
    $credential | Export-Clixml -Path ".\emailcred.xml"
#>

foreach($service in $servicesList)
{
    $currentServiceStatus = (Get-Service -Name $service.Name).Status
    if ($service.status -ne $currentServiceStatus)
    {
        #Log the current status of service and expected status.
        $log = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Service: $($service.Name) is currently $currentServiceStatus, but should be $($service.Status)."
        $log | Out-File -FilePath ".\log.txt" -Append

        #Set status of service to expected status. Check and log if this was successful. Only works if script is run as admin.
        Set-Service -Name $service.Name -Status $service.Status 
        $currentServiceStatus = (Get-Service -Name $service.Name).Status
        if ($service.status -eq $currentServiceStatus)
        {
            $postLog = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Service: $($service.Name) has been set to $($service.Status)."
            $postLog | Out-File -FilePath ".\log.txt" -Append
        }
        else
        {
            $postLog = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Service: $($service.Name) failed to change to $($service.Status)."
            $postLog | Out-File -FilePath ".\log.txt" -Append
        }

        #Send alert if service status is not as expected.
        $sendAlert = $true
    }
    else
    {
        #Log the current status of service, which is the expected status.
        $log = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Service: $($service.Name) is currently $currentServiceStatus, as expected."
        $log | Out-File -FilePath ".\log.txt" -Append
    }
}

if ($sendAlert -eq $true)
{
    #Send alert if any service status was not as expected.
    $subject = "Service Status Alert"
    $body = $log + "`n" + $postLog | Out-String
    Send-MailMessage -From $fromEmail -To $toEmail -Subject $subject -Body $body -SmtpServer $smtpServer -Port $smtpPort -UseSsl -Credential $credential
    $log = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Alert email sent to $toEmail."
    $log | Out-File -FilePath ".\log.txt" -Append
}