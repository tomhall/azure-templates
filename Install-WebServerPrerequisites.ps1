param (
    [parameter()]
    [ValidateNotNullOrEmpty()]
    [String]$NewRelicLicenseKey
)

Write-Host "Installing Octopus Deploy DSC Extension..."
.\Install-OctopusDSC.ps1

Write-Host "Installing New Relic Agents..."
.\Install-NewRelic.ps1 -NewRelicLicenseKey $NewRelicLicenseKey

Write-Host "Installing Chocolatey..."
.\install.ps1