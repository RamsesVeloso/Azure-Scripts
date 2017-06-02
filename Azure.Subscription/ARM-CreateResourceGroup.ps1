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
# Azure Resource Manager (ARM) -- Create Azure Resource Group
########################################################################################

## Location
$resourceGroupName = "INSERT_RESOURCE_GROUP_NAME"
$location = "INSERT_AZURE_REGION"

## Tags
$tag = @{`
    INSERT_TAG1_NAME = "INSERT_TAG1_VALUE";`
    INSERT_TAG2_NAME = "INSERT_TAG2_VALUE";`
    INSERT_TAG3_NAME = "INSERT_TAG3_VALUE"`
    }

########################################################################################

## Create Resource Group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $location -Tag $tags