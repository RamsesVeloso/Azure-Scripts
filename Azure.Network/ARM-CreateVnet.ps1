########################################################################################
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
# OR OTHER DEALINGS IN THE SOFTWARE.
########################################################################################
# PowerShell Scripts Library @ https://pssl.codeplex.com/
########################################################################################
# Azure Resource Manager (ARM) -- Create Virtual Network (VNet)
########################################################################################

## Define variables
$resourceGroupName = "INSERT_RESOURCE_GROUP_NAME"
$location = "INSERT_AZURE_REGION"
$vnetName = "INSERT_VNET_NAME"
$vnetPrefix = "INSERT_CIDR" # Example: "192.168.0.0/16"
$dnsServer1 = "INSERT_DNS_SERVER_IP"
$dnsServer2 = "INSERT_DNS_SERVER_IP"

$subg = "GatewaySubnet" # It is a requirement to use this name for subnet containing VNet gateway.
$subgprefix = "INSERT_SUBNET_IP_RANGE" #Example: "192.168.1.0/24"

$sub1 = "INSERT_SUBNET_NAME"
$sub1prefix = "INSERT_SUBNET_IP_RANGE" #Example: "192.168.2.0/24"

## Define custom Tags
$tags = New-Object System.Collections.ArrayList
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )

########################################################################################

$subnetg = New-AzureRmVirtualNetworkSubnetConfig -Name $subg -AddressPrefix $subgprefix
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name $sub1 -AddressPrefix $sub1prefix

## Create Virtual Network
New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName -Location $location `
-AddressPrefix $vnetPrefix -DnsServer @($dnsServer1,$dnsServer2) -Subnet $subnetg, $subnet1 -Tag $tags