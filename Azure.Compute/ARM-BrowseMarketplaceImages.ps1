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
# Azure Resource Manager (ARM) -- Browse available marketplace VM images
########################################################################################

## Select Azure region
$selectedRegion = (Get-AzureLocation |
     Out-GridView -Title "Select Azure Datacenter Region ..." -PassThru).Name

## Select Image Publisher in above region
$selectedPublisher = (Get-AzureRmVMImagePublisher -Location $selectedRegion |
     Out-GridView -Title "Select Image Publisher ..." -PassThru).PublisherName

## Select Image Offers in above region
$selectedOffer = (Get-AzureRmVMImageOffer -Location $selectedRegion -PublisherName $selectedPublisher |
     Out-GridView -Title "Select Image Offer ..." -PassThru).Offer

## Select Image Offer Skus in above region
$selectedSku = (Get-AzureRMVMImageSku -Location $selectedRegion -PublisherName $selectedPublisher -Offer $selectedOffer |
     Out-GridView -Title "Select Image Offer Sku ..." -PassThru).Skus

## Show all Image Offer Skus Versions in above region
Get-AzureRMVMImage -Location $selectedRegion -Publisher $selectedPublisher -Offer $selectedOffer -Sku $selectedSku |
     Format-Table -Auto

## Select Image Offer Sku Version in above region
$selectedImage = (Get-AzureRMVMImage -Location $selectedRegion -Publisher $selectedPublisher -Offer $selectedOffer -Sku $selectedSku |
     Out-GridView -Title "Select Image Offer Sku Version ..." -PassThru)

## Show selected Image Offer Sku Version
$selectedImage | Format-Table -Auto