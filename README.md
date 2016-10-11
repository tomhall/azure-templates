# Microsoft Azure Resource Manager (ARM) Templates

1. **vmss-win-iis-octopus.json**
 * This ARM template will create a [Virtual Machine Scale Set](https://azure.microsoft.com/en-us/documentation/articles/virtual-machine-scale-sets-overview/ "Virtual Machine Scale Sets") containing Windows Server 2012 R2 Datacenter virtual machine instances (two by default). It will automatically setup a [virtual network](https://azure.microsoft.com/en-us/documentation/articles/resource-groups-networking/#virtual-network), [public IP addresss](https://azure.microsoft.com/en-us/documentation/articles/resource-groups-networking/#public-ip-address), and a [load balancer](https://azure.microsoft.com/en-us/documentation/articles/resource-groups-networking/#load-balancer) to distribute HTTP traffic to your virtual machines, along with inbound NAT rules so that, if neccessary, you can RDP into each VM.
 * **Virtual Machine Configuration:**
    * Installs Chocolatey
    * Installs & configures [New Relic .NET Agent](https://docs.newrelic.com/docs/agents/net-agent/getting-started/new-relic-net) and [New Relic Server Agent](https://docs.newrelic.com/docs/servers/new-relic-servers-windows/getting-started/new-relic-servers-windows) 
    * Installs & configures [Octopus Deploy](https://octopus.com/) tentacle
      * Registers each virtual machine with the specified Octopus Deploy Server
      * Adds the virtual machine to the specified Octopus Deploy environments and roles
      * Assigns the specified [Octopus Deploy Machine Policy](http://docs.octopusdeploy.com/display/OD/Machine+Policies) to the virtual machine
    * Installs & configures IIS
      * ASP.NET 4.5
      * Static Content 
      * Dynamic Content Compression 
      * Static Content Compression 
      * Web Server Management Console
      * [URL Rewrite 2.0](https://www.iis.net/downloads/microsoft/url-rewrite)
   * **Template Parameters:**
