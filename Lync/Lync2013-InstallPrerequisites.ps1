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
# Lync 2013 -- Install Windows Features Prerequisites
########################################################################################

Install-WindowsFeature RSAT-ADDS, `
Web-Server, `
Web-Static-Content, `
Web-Default-Doc, `
Web-Http-Errors, `
Web-Asp-Net, `
Web-Net-Ext, `
Web-ISAPI-Ext, `
Web-ISAPI-Filter, `
Web-Http-Logging, `
Web-Log-Libraries, `
Web-Request-Monitor, `
Web-Http-Tracing, `
Web-Basic-Auth, `
Web-Windows-Auth, `
Web-Client-Auth, `
Web-Filtering, `
Web-Stat-Compression, `
Web-Dyn-Compression, `
NET-WCF-HTTP-Activation45, `
Web-Asp-Net45, `
Web-Mgmt-Tools, `
Web-Scripting-Tools, `
Web-Mgmt-Compat, `
Telnet-Client, `
BITS, `
Desktop-Experience, `
Windows-Identity-Foundation