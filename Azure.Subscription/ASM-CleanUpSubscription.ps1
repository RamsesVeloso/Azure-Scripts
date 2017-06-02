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
# Azure Service Management (ASM) -- Clean up Azure subscription and delete all objects
########################################################################################

## Delete all cloud services and their deployments
Get-AzureService | ForEach-Object {
Remove-AzureDeployment -ServiceName $_.ServiceName -Slot Production -DeleteVHD -Force
Remove-AzureService -ServiceName $_.ServiceName -Force
}

## Find and remove unused Azure disks
Get-AzureDisk | Foreach-Object {
    Remove-AzureDisk -DiskName $_.DiskName -DeleteVHD
    }

## Find and delete all Azure images
Get-AzureVMImage | Foreach-Object {
    Remove-AzureVMImage –ImageName $_.name –DeleteVHD
    }

## Delete all gateway connections
$GWConnection = Get-AzureVirtualNetworkGatewayConnection
ForEach ($GW in $GWConnection) {
Remove-AzureVirtualNetworkGatewayConnection -GatewayId "$($GW.VirtualNetworkGatewayId)" -ConnectedEntityId "$($GW.ConnectedEntityId)"
}

## Delete all gateways
$Gateways = Get-AzureVirtualNetworkGateway
ForEach ($GW in $Gateways) {
Remove-AzureVirtualNetworkGateway -GatewayId "$($GW.GatewayId)"
}