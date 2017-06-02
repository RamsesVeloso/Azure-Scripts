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
# Azure Service Management (ASM) - Rename VM
########################################################################################

## Define variables
$originalVmName = "INSERT_VM_NAME"
$renamedVmName = "INSERT_VM_NAME"

$serviceName = "INSERT_SERVICE_NAME"

$workingPath = "INSERT_WORKING_PATH" # Example: "C:\Temp"

########################################################################################

## Retrieve information about the VM disks and export the VM configuration to a XML file
Select-AzureSubscription -SubscriptionId $sourceSubscriptionId
Stop-AzureVM –ServiceName $sourceServiceName –Name $sourceVmName -Force
$sourceVm = Get-AzureVM –ServiceName $sourceServiceName –Name $sourceVmName
$vmConfigurationPath = $workingPath + “\exportedVM.xml”
$sourceVm | Export-AzureVM -Path $vmConfigurationPath
$sourceOSDisk = $sourceVm.VM.OSVirtualHardDisk
$sourceDataDisks = $sourceVm.VM.DataVirtualHardDisks