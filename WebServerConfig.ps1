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
			DependsOn = "[WindowsFeaturesWebServer]windowsFeatures"
			Ensure = "Present"
			Name = "IIS URL Rewrite Module 2"
			Path = "http://download.microsoft.com/download/6/7/D/67D80164-7DD0-48AF-86E3-DE7A182D6815/rewrite_2.0_rtw_x64.msi"
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