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
# Active Directory Domain Services (ADDS) -- Test connectivity to Domain Controller (DC)
########################################################################################

## Define variables
$path = "INSERT_PATH"
$runDate = (Get-Date).ToString('yyyy-MM-dd')
$dateTime = Get-Date -UFormat "%Y-%m-%d_%H-%M"
$fileName = $dateTime
$saveToFile = $path + "\" + $fileName + ".csv"

$servers = `
"INSERT_SERVER_NAME",`
"INSERT_SERVER_NAME",`
"INSERT_SERVER_NAME",`
"INSERT_SERVER_NAME"

## Execute tests
ForEach ($server in $servers)
{

Write-Host "Test LDAP (TCP and UDP 389	Directory, Replication, User and Computer Authentication, Group Policy, Trusts	LDAP)"
Test-NetConnection -Computer $server -Port 389 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test LDAP SSL (Directory, Replication, User and Computer Authentication, Group Policy, Trusts)"
Test-NetConnection -Computer $server -Port 636 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test LDAP GC (Directory, Replication, User and Computer Authentication, Group Policy, Trusts)"
Test-NetConnection -Computer $server -Port 3268 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test LDPA GC SSL (Directory, Replication, User and Computer Authentication, Group Policy, Trusts)"
Test-NetConnection -Computer $server -Port 3269 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test Kerberos (User and Computer Authentication, Forest Level Trusts)"
Test-NetConnection -Computer $server -Port 88 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test DNS (User and Computer Authentication,  Resolution, Trusts)"
Test-NetConnection -Computer $server -Port 53 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test SMB (Replication, User and Computer Authentication, Group Policy, Trusts)"
Test-NetConnection -Computer $server -Port 445 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test SMTP (Replication)"
Test-NetConnection -Computer $server -Port 25 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test RPC (Replication)"
Test-NetConnection -Computer $server -Port 135 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test DFSR (File Replication)"
Test-NetConnection -Computer $server -Port 5722 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test Windows Time (Windows Time, Trusts)"
Test-NetConnection -Computer $server -Port 123 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test Kerberos change/set password (Replication, User and Computer Authentication, Trusts)"
Test-NetConnection -Computer $server -Port 464 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test DFSN (DFS, Group Policy)"
Test-NetConnection -Computer $server -Port 138 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test SOAP (AD DS Web Services)"
Test-NetConnection -Computer $server -Port 9389 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test NetLogon (User and Computer Authentication)"
Test-NetConnection -Computer $server -Port 137 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test DFSN (User and Computer Authentication, Replication)"
Test-NetConnection -Computer $server -Port 139 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

Write-Host "Test FrsRpc (from a writeable DC to the RODC)"
Test-NetConnection -Computer $server -Port 53248 -InformationLevel "Detailed" |
Export-Csv –Append -Path $saveToFile -Encoding UTF8 -UseCulture -NoTypeInformation

}