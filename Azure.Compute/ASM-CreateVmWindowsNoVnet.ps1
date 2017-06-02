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
# Azure Service Management (ASM) - Create VM in existing cloud service without VNet
########################################################################################

## Define variables
$subscriptionId = "INSERT_SUBSCRIPTION_ID"
$location = "INSERT_LOCATION"
$timeZone = "Eastern Standard Time"
$storageName = "INSERT_STORAGE_ACCOUNT"
$serviceName = "INSERT_SERVICE_NAME"
$availabilitySetName = "INSERT_AVAILABILITY_SET"

## Specify VM name and size
$vmName = "INSERT_VM_NAME"
$vmSize = "Medium"

## Specify VM image 
$imageName = "INSERT_IMAGE_NAME" 

## Define administrative login credentials for VM
$username = "AdminUser"
$password = ConvertTo-SecureString –String "Pass@word1" –AsPlainText -Force

########################################################################################

## Set storage account
Select-AzureSubscription -SubscriptionId $subscriptionId –Current
Set-AzureSubscription -SubscriptionId $subscriptionId -CurrentStorageAccount $storageName

## Setup local VM object
$image = Get-AzureVMImage -ImageName $imageName
$virtualMachine = New-AzureVMConfig -Name $vmName -InstanceSize $vmSize -ImageName $image -AvailabilitySetName $availabilitySetName
$virtualMachine | Add-AzureProvisioningConfig -Windows -AdminUsername $username -Password $password -TimeZone $timeZone

## Create VM
New-AzureVM -ServiceName $serviceName -Location $location -VMs $virtualMachine -WaitForBoot

## Stop and deallocate VM to remove CD-ROM drive, then start it
## NOTE: This is executed to mitigate an Azure bug
Stop-AzureVM -ServiceName $serviceName -Name $vmName -Force
Start-AzureVM -ServiceName $serviceName -Name $vmName