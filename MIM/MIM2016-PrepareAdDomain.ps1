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
# Microsoft Identity Manager 2016 -- Prepare AD domain
########################################################################################

## Define variables
$password = ConvertTo-SecureString "Pass@word1" –AsPlainText –Force
$domainController = "dc.contoso.com"
$netbiosDomain = "CONTOSO"

Import-Module ActiveDirectory
New-ADUser –SamAccountName MIMMA –name MIMMA 
Set-ADAccountPassword –identity MIMMA –NewPassword $password
Set-ADUser –identity MIMMA –Enabled 1 –PasswordNeverExpires 1
New-ADUser –SamAccountName MIMSync –name MIMSync 
Set-ADAccountPassword –identity MIMSync –NewPassword $password
Set-ADUser –identity MIMSync –Enabled 1 –PasswordNeverExpires 1
New-ADUser –SamAccountName MIMService –name MIMService 
Set-ADAccountPassword –identity MIMService –NewPassword $password
Set-ADUser –identity MIMService –Enabled 1 –PasswordNeverExpires 1
New-ADUser –SamAccountName MIMSSPR –name MIMSSPR 
Set-ADAccountPassword –identity MIMSSPR –NewPassword $password
Set-ADUser –identity MIMSSPR –Enabled 1 –PasswordNeverExpires 1
New-ADUser –SamAccountName SharePoint –name SharePoint 
Set-ADAccountPassword –identity SharePoint –NewPassword $password
Set-ADUser –identity SharePoint –Enabled 1 –PasswordNeverExpires 1
New-ADUser –SamAccountName SqlServer –name SqlServer 
Set-ADAccountPassword –identity SqlServer –NewPassword $password
Set-ADUser –identity SqlServer –Enabled 1 –PasswordNeverExpires 1
New-ADUser –SamAccountName BackupAdmin –name BackupAdmin 
Set-ADAccountPassword –identity BackupAdmin –NewPassword $password
Set-ADUser –identity BackupAdmin –Enabled 1 -PasswordNeverExpires 1

New-ADGroup –name MIMSyncAdmins –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncAdmins
New-ADGroup –name MIMSyncOperators –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncOperators
New-ADGroup –name MIMSyncJoiners –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncJoiners
New-ADGroup –name MIMSyncBrowse –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncBrowse
New-ADGroup –name MIMSyncPasswordReset –GroupCategory Security –GroupScope Global –SamAccountName MIMSyncPasswordReset 
Add-ADGroupMember -identity MIMSyncAdmins -Members Administrator
Add-ADGroupmember -identity MIMSyncAdmins -Members MIMService

setspn -S http/$domainController $netbiosDomain\SharePoint
setspn -S http/$domainController $netbiosDomain\SharePoint
setspn -S FIMService/$domainController $netbiosDomain\MIMService
setspn -S FIMSync/$domainController $netbiosDomain\MIMSync