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
# Windows Server -- Install all IIS features on Windows Server 2012 R2
########################################################################################

## Show installed IIS components
Get-WindowsFeature –Name Web-*

## Install Web Server (IIS) including all role services and applicable management tools
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools

## Show installed IIS components
Get-WindowsFeature –Name Web-*

## Run Windows Update
wuauclt.exe /detectnow
wuapp.exe