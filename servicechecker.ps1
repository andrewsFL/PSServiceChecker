$servicesFilePath = ".\services.csv"
$servicesList = Import-Csv -Path $servicesFilePath -Delimiter ','

foreach($service in $servicesList)
{
    $currentServiceStatus = (Get-Service -Name $service.Name).Status
    if ($service.status -ne $currentServiceStatus)
    {
        $log = "Service: $($service.Name) is currently $currentServiceStatus, but should be $($service.Status)."
        $log | Out-File -FilePath ".\log.txt" -Append
    }
    else
    {
        $log = "Service: $($service.Name) is currently $currentServiceStatus, as expected."
        $log | Out-File -FilePath ".\log.txt" -Append
    }
}