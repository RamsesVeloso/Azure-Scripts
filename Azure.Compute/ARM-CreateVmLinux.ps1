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
# Azure Resource Manager (ARM) -- Create Linux Virtual Machine
########################################################################################

## Define variables
## Specify exiting resource group and location for the VM
$resourceGroupName = "MyVMResourceGroup"
$location = "eastus"

## Specify existing storage account to create VM disks in
$storageName = "mystorage"

## Specify NIC settings and existing virtual network subnet
$networkInterfaceName = "MyVM-NIC"
$ipAddress = "10.0.0.10"
$vnetResourceGroup = "MyVNetResourceGroup"
$vnetName = "MyVNet"
$subnetName = "MySubnet"

## Specify VM size and image
$vmName = "MyVM"
$vmSize = "Standard_A2"
$publisherName = "RedHat"
$offer = "RHEL" 
$sku = "7.2"

## Define administrative login credentials for the VM
$username = "AdminUser"
$password = ConvertTo-SecureString –String "Pass@word1" –AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

## Define custom Tags
$tags = New-Object System.Collections.ArrayList
$tags.Add( @{ Name = "site"; Value = "primary" } )
$tags.Add( @{ Name = "environment"; Value = "test" } )

########################################################################################

## Create NIC
$vnet=Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $vnetResourceGroup
$subnet=(Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet).Id
New-AzureRmNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroupName -Location $location `
-SubnetID $subnet -PrivateIpAddress $ipAddress -Tag $tags

## Get storage info
$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageName

## Get network info
$networkInterface = Get-AzureRmNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroupName

## Setup local VM object
$virtualMachine = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

## Add additional data disk to the VM
$diskSize = 1023
$diskName = "DataDisk"
$hostCachePreference = "ReadWrite"
$diskLabel = $vmName + "." + $diskName
$vhdURI = $StorageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $vmName + "." + $diskName  + ".vhd"
Add-AzureRmVMDataDisk -VM $virtualMachine -Name $diskLabel -VhdUri $vhdURI -Caching $hostCachePreference -DiskSizeInGB $diskSize -CreateOption Empty

## Finish setup of local VM object
$virtualMachine = Set-AzureRmVMOperatingSystem -VM $virtualMachine -Linux -ComputerName $vmName -Credential $credential
$virtualMachine = Set-AzureRmVMSourceImage -VM $virtualMachine -PublisherName $publisherName -Offer $offer -Skus $sku -Version "latest"
$virtualMachine = Add-AzureRmVMNetworkInterface -VM $virtualMachine -Id $networkInterface.Id
$osDiskName = $vmName + ".OSDisk"
$osDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $osDiskName + ".vhd"
$virtualMachine = Set-AzureRmVMOSDisk -VM $virtualMachine -Name $osDiskName -VhdUri $osDiskUri -CreateOption FromImage

## Create VM
New-AzureRmVM -ResourceGroupName $resourceGroupName -Location $location -VM $virtualMachine -Tag $tags

## Stop and deallocate VM to remove CD-ROM drive, then start it
## NOTE: This is executed to mitigate an Azure bug
Stop-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName -Force
Start-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName