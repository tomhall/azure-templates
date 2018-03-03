param (
    [parameter()]
    [ValidateNotNullOrEmpty()]
    [String]$NewRelicLicenseKey
)

function downloadFile($uri, $outfileName) {
	Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile $outfileName
	return Resolve-Path $outfileName
}

# Install New Relic Dot Net Agent
$fileName = "NewRelicDotNetAgent_x64.msi"
$filePath = downloadFile https://download.newrelic.com/dot_net_agent/latest_release/NewRelicDotNetAgent_x64.msi $fileName
Start-Process "msiexec.exe" -ArgumentList "/i", "$filePath", "/qb", "NR_LICENSE_KEY=$NewRelicLicenseKey", 'INSTALLLEVEL=1'

# Install New Relic Server Agent
$fileName = "NewRelicServerMonitor_x64_3.3.6.0.msi"
$filePath = downloadFile "https://download.newrelic.com/windows_server_monitor/release/NewRelicServerMonitor_x64_3.3.6.0.msi" $fileName
Start-Process "msiexec" -ArgumentList "/i", "$filePath", "/L*v", "install.log", "/qn", "NR_LICENSE_KEY=$NewRelicLicenseKey"