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
# Azure Service Management (ASM) - Remove endpoint from specified VMs
########################################################################################

## Define variables
$serviceName = "INSERT_SERVICE_NAME"
$endpointName = "INSERT_ENDPOINT_NAME" # Example: "RemoteDesktop"

## Specify VM names
$vms = `
"INSERT_VM1_NAME",`
"INSERT_VM2_NAME",`
"INSERT_VM3_NAME"

########################################################################################

ForEach ($vm in $vms)
{
    $vmConfig = Get-AzureVM -ServiceName $serviceName -Name $vm
    
    ## If found, remove and update
    if ($vmConfig | Get-AzureEndpoint -Name $endpointName)
    {
        $vmConfig | Remove-AzureEndpoint -Name $endpointName 
        $vmConfig | Update-AzureVM
    }
}