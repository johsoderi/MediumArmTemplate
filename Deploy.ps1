$principalName = Read-Host -Prompt "Azure login name [default: 'joso1801@nackademin.se']"
if ([string]::IsNullOrWhiteSpace($principalName)) { $principalName = "joso1801@nackademin.se" }

az login -u $principalName

#$adUserId = (Get-AzADUser -UserPrincipalName $principalName).Id

$projectName = Read-Host -Prompt "Deployment name [default: 'MediumARMtemplate']"
if ([string]::IsNullOrWhiteSpace($projectName)) { $projectName = "MediumARMtemplate" }
# Naming rules:
#   Resource Group: Only alphanumeric characters, periods, underscores, hyphens, and parenthesis. Up to 90 characters.

$loc = "North Europe"
$rg = ($projectName + "Rg")

$adminUsername = Read-Host -Prompt "Choose a username for the server Administrator accounts [default: 'serveradmin']"
if ([string]::IsNullOrWhiteSpace($adminUsername)) { $adminUsername = "serveradmin" }

#$adminPassword = Read-Host -Prompt ("Choose a password for " + $adminUsername) -AsSecureString
$generatedPw = [System.Web.Security.Membership]::GeneratePassword(25,10)
$adminPassword = ConvertTo-SecureString -String $generatedPw -AsPlainText -Force
Write-Output ("A secure password for '" + $adminUsername + "' was generated and will be stored in the following Azure Key Vault: : " + $rg + "/" + $rg + "Vault")

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
New-AzResourceGroupDeployment -DeploymentDebugLogLevel All -ResourceGroupName $rg `
    -TemplateUri https://raw.githubusercontent.com/johsoderi/MediumArmTemplate/master/MainTemplate.json `
    -adminPassword $adminPassword -adminUsername $adminUsername -projectName $projectName
#-adUserId $adUserId 