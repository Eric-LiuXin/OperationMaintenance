# Create SQL Server Account and add roles for it

param(
[string]$instanceName=$(throw "Parameter missing: -instanceName instanceName"),
[string]$loginName=$(throw "Parameter missing: -loginName loginName"),
[string]$password=$(throw "Parameter missing: -password password")
)

Import-Module SQLPS -DisableNameChecking

$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

# drop login if it exists
if ($server.Logins.Contains($loginName))  
{   
    Write-Host("Deleting the existing login $loginName.")
    $server.Logins[$loginName].Drop() 
}

$login = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login -ArgumentList $server, $loginName
$login.LoginType = [Microsoft.SqlServer.Management.Smo.LoginType]::SqlLogin
$login.PasswordExpirationEnabled = $false
$login.PasswordPolicyEnforced = $false
$login.Create($password)
Write-Host("Login $loginName created successfully.")

$login.AddToRole("dbcreator")
$login.AddToRole("processadmin")
$login.AddToRole("setupadmin")
$login.Alter()
