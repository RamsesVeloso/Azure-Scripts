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
# Azure Resource Manager (ARM) -- Create Virtual Network (VNet) Gateway
########################################################################################

## Define variables
$resourceGroupName = "INSERT_RESOURCE_GROUP_NAME"
$location = "INSERT_AZURE_REGION"
$vnetName = "INSERT_VNET_NAME"
$publicIPName = "INSERT_PUBLIC_IP_NAME"
$gwConfigName = "INSERT_GATEWAY_CONFIG_NAME"
$gwName = "INSERT_GATEWAY_NAME"
$gwSku = "Basic"
$gwType = "VPN"
$vpnType = "RouteBased"

## Define custom Tags
$tags = New-Object System.Collections.ArrayList
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )

########################################################################################

## Create Public IP address
$gwPIP = New-AzureRmPublicIpAddress -Name $publicIPName -ResourceGroupName $resourceGroupName `
-Location $location -AllocationMethod Dynamic -Tag $Tags

## Create gateway configuration
$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet
$gwIPConfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name $gwConfigName -SubnetId $subnet.Id `
-PublicIpAddressId $gwPIP.Id

## Create gateway
New-AzureRmVirtualNetworkGateway -Name $gwName -ResourceGroupName $resourceGroupName `
-Location $location -IpConfigurations $gwIPConfig -GatewayType $gwType -VpnType $VPNType `
-GatewaySku $GWSku -Tag $Tags