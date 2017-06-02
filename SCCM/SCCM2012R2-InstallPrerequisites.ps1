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
# SCCM 2012 R2 -- Install Windows Features Prerequisites
########################################################################################

Install-WindowsFeature BITS, `
BITS-IIS-Ext, `
RDC, `
Web-Server, `
Web-Static-Content, `
Web-Default-Doc, `
Web-DAV-Publishing, `
Web-Windows-Auth, `
Web-ISAPI-Ext, `
Web-Metabase, `
Web-WMI, `
Web-Asp-Net, `
Web-Asp-Net45, `
Web-Mgmt-Console, `
NET-Framework-Features, `
NET-Framework-Core, `
NET-HTTP-Activation, `
NET-Non-HTTP-Activ