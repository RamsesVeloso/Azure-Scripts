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
# Azure Resource Manager (ARM) -- Login to Azure and select subscription
########################################################################################

## Sign-in with Azure account credentials
Login-AzureRmAccount

## Select Azure Subscription
$subscriptionId = (Get-AzureRmSubscription |
     Out-GridView -Title "Select an Azure Subscription ..." -PassThru).SubscriptionId
Select-AzureRmSubscription -SubscriptionId $subscriptionId
Get-AzureRmSubscription -SubscriptionId $subscriptionId | Set-AzureRmContext

## Download updated Help Topics
Update-Help

## Verify active subscription
Get-AzureRmContext