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
# Active Directory Domain Services (ADDS) -- Deploy new AD forest unattended
########################################################################################

Import-Module ServerManager
Install-WindowsFeature -name AD-Domain-Services –IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-InstallDns:$true `
-DomainMode "Win2012R2" `sure
-ForestMode "Win2012R2" `
-DomainName "ad.contoso.com" `
-DomainNetbiosName "CONTOSO" `
-SafeModeAdministratorPassword (ConvertTo-SecureString "Pass@word1" -AsPlainText -Force)
-DatabasePath "E:\NTDS" `
-LogPath "E:\NTDS" `
-SysvolPath "E:\SYSVOL" `
-NoRebootOnCompletion:$false `
-Force:$true