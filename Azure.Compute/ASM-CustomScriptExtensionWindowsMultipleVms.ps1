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
# Azure Service Management (ASM) - Apply Custom Script Extension to multiple Windows VMs
########################################################################################

## Define variables
$subscriptionId = "INSERT_SUBSCRIPTION_ID"
$location = "INSERT_LOCATION"
$storageName = "INSERT_STORAGE_ACCOUNT"
$containerName = "INSERT_CONTAINER_NAME" # Example: "scripts"
$workingPath = "INSERT_WORKING_PATH" # Example: "C:\Upload\"
$uploadFolderName = "INSERT_FOLDER_NAME" # Example: "deploy"
$fileName1 = "INSERT_FILE_NAME"
$fileName2 = "INSERT_FILE_NAME"
$serviceName = "INSERT_SERVICE_NAME"

## Specify VM names
$vms = "INSERT_VM1_NAME","INSERT_VM2_NAME","INSERT_VM3_NAME"

########################################################################################

## Set storage account
Select-AzureSubscription -SubscriptionId $subscriptionId -Current
Set-AzureSubscription -SubscriptionId $subscriptionId -CurrentStorageAccount $storageAccountName
$storageAccountKey = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary
$storageContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

## Verify the target storage account has a container for the scripts
if ((Get-AzureStorageContainer -Context $storageContext -Name $containerName -ErrorAction SilentlyContinue) -eq $null)
{
    New-AzureStorageContainer -Context $storageContext -Name $containerName -Permission Off
}

## Upload all config files to blob storage
Get-ChildItem -Path $workingPath\$uploadFolderName\* | Set-AzureStorageBlobContent -Container $containerName

ForEach ($vm in $vms)
{
    ## Execute Custom Script Extension
    Get-AzureVM -ServiceName $serviceName -Name $vmName | `
    Set-AzureVMCustomScriptExtension -ContainerName $containerName -FileName $fileName1,$fileName2 `
        -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey -Run $fileName1 -ForceUpdate | `
    Update-AzureVM

    # Viewing the script execution output
    Write-Host "$(Get-Date –f $timeStampFormat) - Custom Script Extension status for $vmName"
    $vmStatus = Get-AzureVM -ServiceName $serviceName -Name $vmName
    # Use the position of the extension in the output as index
    $vmStatus.ResourceExtensionStatusList[1].ExtensionSettingStatus.SubStatusList
}

## Cleanup all config files from blob storage
Start-Sleep 300
#Get a reference to all the blobs in the container
$blobsToDelete = Get-AzureStorageBlob -Container $containerName -Context $storageContext
#Delete blobs in a specified container.
$blobsToDelete | Remove-AzureStorageBlob