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
# Azure Resource Manager (ARM) -- Create Public IP address
########################################################################################

## Define variables
$resourceGroupName = "INSERT_RESOURCE_GROUP_NAME"
$location = "INSERT_AZURE_REGION"
$publicIPName = "INSERT_PUBLIC_IP_NAME"

## Define custom Tags
$tags = New-Object System.Collections.ArrayList
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )
$tags.Add( @{ Name = "INSERT_NAME"; Value = "INSERT_VALUE" } )

########################################################################################

## Create Public IP address
New-AzureRmPublicIpAddress -Name $publicIPName -ResourceGroupName $resourceGroupName `
-Location $location -AllocationMethod Dynamic -Tag $Tags