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
# Azure Service Management (ASM) - Move VM and disks to different storage account and/or
# subscription (unattended)
########################################################################################

## Define variables
$sourceSubscriptionId = "INSERT_SUBSCRIPTION_ID"
$sourceVmName = "INSERT_VM_NAME"
$sourceServiceName = "INSERT_SERVICE_NAME"

## Define destination
$destSubscriptionId = "INSERT_SUBSCRIPTION_ID"
$destLocation = "INSERT_LOCATION"
$destVmName = "INSERT_VM_NAME"
$destServiceName = "INSERT_SERVICE_NAME"
$destStorageAccountName = "INSERT_STORAGE_ACCOUNT"

## Define working directory path
$workingPath = "INSERT_WORKING_PATH" # Example: "C:\Temp"

########################################################################################

## Retrieve information about the VM disks and export the VM configuration to a XML file
Select-AzureSubscription -SubscriptionId $sourceSubscriptionId
Stop-AzureVM –ServiceName $sourceServiceName –Name $sourceVmName -Force
$sourceVm = Get-AzureVM –ServiceName $sourceServiceName –Name $sourceVmName
$vmConfigurationPath = $workingDir + “\exportedVM.xml”
$sourceVm | Export-AzureVM -Path $vmConfigurationPath
$sourceOSDisk = $sourceVm.VM.OSVirtualHardDisk
$sourceDataDisks = $sourceVm.VM.DataVirtualHardDisks

## Get the Windows Azure storage account name containing the original VM VHDs, and its access key
$sourceStorageName = $sourceOSDisk.MediaLink.Host -split “\.” | select -First 1
$sourceStorageAccount = Get-AzureStorageAccount –StorageAccountName $sourceStorageName
$sourceStorageKey = (Get-AzureStorageKey -StorageAccountName $sourceStorageName).Primary

## Get the information for destination storage account
Select-AzureSubscription -SubscriptionId $destSubscriptionId
$destStorageAccount = Get-AzureStorageAccount -StorageAccountName $destStorageAccountName	
$destStorageName = $destStorageAccount.StorageAccountName
$destStorageKey = (Get-AzureStorageKey -StorageAccountName $destStorageName).Primary

## Create the required storage context variables
$sourceContext = New-AzureStorageContext –StorageAccountName $sourceStorageName -StorageAccountKey $sourceStorageKey
$destContext = New-AzureStorageContext –StorageAccountName $destStorageName -StorageAccountKey $destStorageKey

## Verify the target storage account has a container for the VHDs
If ((Get-AzureStorageContainer -Context $destContext -Name vhds -ErrorAction SilentlyContinue) -eq $null)
{
    New-AzureStorageContainer -Context $destContext -Name vhds
}

## Copy the VHDs from the source storage to the destination storage	
$allDisks = @($sourceOSDisk) + $sourceDataDisks
$destDataDisks = @()
ForEach($disk in $allDisks)
{
    $blobName = $disk.MediaLink.Segments[2]
    $targetBlob = Start-AzureStorageBlobCopy -SrcContainer vhds -SrcBlob $blobName -Context $sourceContext -DestContainer vhds -DestBlob $blobName -DestContext $destContext -Force
    Write-Host “Copying blob $blobName”
    $copyState = $targetBlob | Get-AzureStorageBlobCopyState
    While ($copyState.Status -ne “Success”)
    {
        $percent = ($copyState.BytesCopied / $copyState.TotalBytes) * 100
        Write-Host “Completed $(‘{0:N2}’ -f $percent)%”
        sleep -Seconds 5
        $copyState = $targetBlob | Get-AzureStorageBlobCopyState
    }
    If ($disk -eq $sourceOSDisk)
    {
        $destOSDisk = $targetBlob
    }
    Else
    {
        $destDataDisks += $targetBlob
    }
}

## Register the new disks as data/OS disks
Add-AzureDisk -OS $sourceOSDisk.OS -DiskName $sourceOSDisk.DiskName -MediaLocation $destOSDisk.ICloudBlob.Uri
ForEach($currenDataDisk in $destDataDisks)
{
    $diskName = ($sourceDataDisks | ? {$_.MediaLink.Segments[2] -eq $currenDataDisk.Name}).DiskName
    Add-AzureDisk -DiskName $diskName -MediaLocation $currenDataDisk.ICloudBlob.Uri
}

## Create the new VM in the new subscription
Select-AzureSubscription -SubscriptionId $destSubscriptionId
Set-AzureSubscription -SubscriptionId $destSubscriptionId -CurrentStorageAccountName $destStorageName
$vmConfig = Import-AzureVM -Path $vmConfigurationPath
New-AzureVM -ServiceName $destServiceName -Location $destLocation -VMs $vmConfig -WaitForBoot -Verbose