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
# Office 365 - Disconnect from all Office 365 PowerShell sessions
########################################################################################

## Show current PowerShell remote sessions
Get-PSSession

## Disconnect Skype for Business Online session
Remove-PSSession $sfboSession

## Disconnect Exchange Online session
Remove-PSSession $exchangeSession

## Disconnect Security & Compliance Center session
Remove-PSSession $ccSession

## Confirm PowerShell remote sessions disconnected
Get-PSSession

## Disconnect SharePoint Online session
Disconnect-SPOService

## Confirm SharePoint Online session disconnected
Get-SPOSite