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
# Azure Service Management (ASM) -- Login to Azure and select subscription
########################################################################################

## Sign-in with Azure account credentials
Add-AzureAccount

## Select Azure Subscription
$subscriptionId = (Get-AzureSubscription |
     Out-GridView -Title "Select an Azure Subscription ..." -PassThru).SubscriptionId
Select-AzureSubscription -SubscriptionId $subscriptionId
Get-AzureSubscription | Format-Table -AutoSize

## Download updated Help Topics
Update-Help