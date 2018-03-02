Configuration WebServerConfig
{
    param ($ApiKey, $OctopusServerUrl, $Environments, $Roles, $MachinePolicy, $ListenPort, $CommsStyle)

    Import-DscResource -Module OctopusDSC

	Node ("localhost")
	{
		#Install the IIS Role
		WindowsFeature IIS
		{
			Ensure = "Present"
			Name = "Web-Server"
		}

		#Install ASP.NET 4.5
		WindowsFeature ASP45
		{
			Ensure = "Present"
			Name = "Web-Asp-Net45"
		}

		#Install Application Initialization
		WindowsFeature AppInit
		{
			Ensure = "Present"
			Name = "Web-AppInit"
		}

		#Install Static Content
		WindowsFeature StaticContent
		{
			Ensure = "Present"
			Name = "Web-Static-Content"
		}

		#Install Dynamic Content Compression
		WindowsFeature DynamicContentCompression
		{
			Ensure = "Present"
			Name = "Web-Dyn-Compression"
		}
		
		#Install Static Content Compression
		WindowsFeature StaticContentCompression
		{
			Ensure = "Present"
			Name = "Web-Stat-Compression"
		}

		#Install IIS Web Server Management Console
		WindowsFeature WebServerManagementConsole
		{
			Name = "Web-Mgmt-Console"
			Ensure = "Present"
		}

		#Install URL Rewrite module for IIS
		Package UrlRewrite
		{
			DependsOn = "[WindowsFeature]IIS"
			Ensure = "Present"
			Name = "IIS URL Rewrite Module 2.1"
			Path = "http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi"
			Arguments = "/quiet"
			ProductId = "EB675D0A-2C95-405B-BEE8-B42A65D23E11"
		}
		
		#Install Octopus Deploy Tentacle
		cTentacleAgent OctopusTentacle 
        { 
            Ensure = "Present"; 
            State = "Started"; 

            Name = "Tentacle";

            ApiKey = $ApiKey;
            OctopusServerUrl = $OctopusServerUrl;
            Environments = $Environments;
            Roles = $Roles;
						MachinePolicy = $MachinePolicy;
						CommsStyle = $CommsStyle;
			
            ListenPort = $ListenPort;
            DefaultApplicationDirectory = "C:\Applications"
        }
	}
} 