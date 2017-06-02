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
# Azure Resource Manager (ARM) -- Delete Virtual Machine and its disks
########################################################################################

## Define variables
$vmToDeleteName = "INSERT_VM_NAME"
$vmToDeleteResourceGroupName = "INSERT_RESOURCE_GROUP_NAME"
$vmToDeleteStorageAccountName = "INSERT_STORAGE_ACCOUNT"

########################################################################################

## Delete VM
Remove-AzureRmVM -ResourceGroupName $vmToDeleteResourceGroupName -Name $vmToDeleteName -Verbose

## Find VM disks to delete
$storageContext = (Get-AzureRmStorageAccount -ResourceGroupName $vmToDeleteResourceGroupName -Name $vmToDeleteStorageAccountName).Context
$storageBlob = Get-AzureStorageBlob -Context $storageContext -Container "vhds"
$vhdToDeleteList = $storageBlob | Where-Object{$_.Name -match "$vmToDeleteName"}

## Delete disks
ForEach($diskName in $vhdToDeleteList.Name)
{
    Remove-AzureStorageBlob -Blob $diskName -Container "vhds" -Context $storageContext -Verbose
}