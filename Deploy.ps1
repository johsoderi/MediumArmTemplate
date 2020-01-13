$principalName = Read-Host -Prompt "Azure login name [default: 'joso1801@nackademin.se']"
if ([string]::IsNullOrWhiteSpace($principalName)) { $principalName = "joso1801@nackademin.se" }

az login -u $principalName

$adUserId = (Get-AzADUser -UserPrincipalName $principalName).Id

$projectName = Read-Host -Prompt "Deployment name [default: 'MediumARMtemplate']"
if ([string]::IsNullOrWhiteSpace($projectName)) { $projectName = "MediumARMtemplate" }
# Naming rules:
#   Resource Group: Only alphanumeric characters, periods, underscores, hyphens, and parenthesis. Up to 90 characters.

$loc = "North Europe"
$rg = ($projectName + "RG")

$adminUsername = Read-Host -Prompt "Choose a username for the server Administrator account [default: 'serveradmin']"
if ([string]::IsNullOrWhiteSpace($adminUsername)) { $adminUsername = "serveradmin" }

#$adminPassword = Read-Host -Prompt ("Choose a password for " + $adminUsername) -AsSecureString
# Lägg in alt. för generated pw! Testa om IsNullOrWhiteSpace funkar på securestr, annars släng in en switch typ?
$generatedPw = [System.Web.Security.Membership]::GeneratePassword(25,10)
$adminPassword = ConvertTo-SecureString -String $generatedPw -AsPlainText -Force
Write-Output ("Generated secure password for " + $adminUsername + ". It will be stored in Azure Key Vault: : " + $rg + "/" + $rg + "Vault")

Write-Output ("Attempting to delete Resource Group: " + $rg)
az group delete -n $rg --yes
Write-Output ("Done.")

Write-Output ("Creating Resource Group: " + $rg)
az group create -l $loc -n $rg
Write-Output ("Done.")

Write-Output ("Running MainTemplate.json...")
# az group deployment create --name "$projectName" --resource-group "$rg" --template-file ~/Documents/MediumArmTemplate/MainTemplate.json `
#   --parameters adminPassword=$adminPassword adUserId=$adUserId projectName=$projectName
# Ovan fuckar upp securestring på nåt sätt, bytte till New-AzResourceGroupDeployment:
New-AzResourceGroupDeployment -DeploymentDebugLogLevel All -ResourceGroupName $rg -TemplateFile ~/Documents/MediumArmTemplate/MainTemplate.json `
    -adminPassword $adminPassword -adminUsername $adminUsername -adUserId $adUserId -projectName $projectName
# Skapa en repo och byt sen till -templateUri "https://raw.githubusercontent.com/.../MainTemplate.json"
