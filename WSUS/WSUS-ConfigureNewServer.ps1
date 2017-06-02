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
# WSUS -- Install Windows Features Prerequisites
########################################################################################

## Get WSUS Server Object
$wsus = Get-WSUSServer

## Connect to WSUS server configuration
$wsusConfig = $wsus.GetConfiguration()

## Set to download updates from Microsoft Updates
Set-WsusServerSynchronization –SyncFromMU

## Set Update Languages to English and save configuration settings
$wsusConfig.AllUpdateLanguagesEnabled = $false           
$wsusConfig.SetEnabledUpdateLanguages("en")           
$wsusConfig.Save()

## Get WSUS Subscription and perform initial synchronization to get latest categories
$subscription = $wsus.GetSubscription()
$subscription.StartSynchronizationForCategoryOnly()

While ($subscription.GetSynchronizationStatus() -ne 'NotProcessing') {
    $LastCheck = Get-Date
    Write-Host "Sync status last checked: $LastCheck waiting..." #-NoNewline
    Start-Sleep -Seconds 60
}
Write-Host "Sync is done."