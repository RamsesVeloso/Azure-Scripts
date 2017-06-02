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
# Azure Service Management (ASM) - Set VM's IP address to static
########################################################################################

## Define variables
$serviceName = "INSERT_SERVICE_NAME"
$vmName = "INSERT_VM_NAME"

########################################################################################

## Set IP address to static
$currentIp = Get-AzureVM -ServiceName $serviceName -Name $vmName | Select-Object *IP*
Get-AzureVM -ServiceName $serviceName -Name $vmName | `
Set-AzureStaticVNetIP -IPAddress $currentIp.IpAddress | Update-AzureVM