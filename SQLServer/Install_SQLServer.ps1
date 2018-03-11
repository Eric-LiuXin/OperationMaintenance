# Install Sql Server And Create Instance
# Need Input SQL Server Package

param(
[string]$SQLPackage=$(throw "Parameter missing: -SQLPackage SQLPackage"),
[string]$SQLPath=$(throw "Parameter missing: -SQLPath SQLPath"),
[string]$configFile=$(throw "Parameter missing: -configFile configFile")
)

Function InstallSQLServer
{
    if (Test-Path "C:\Program Files\Microsoft SQL Serve"){
        return
    }
    $locationPath=Get-Location
    $tempDir = Join-Path $locationPath "Tmp"
    $TargetFile=Join-Path $SQLPath $SQLPackage
    $localFile=Join-Path $tempDir $package

    if (-not (Test-Path $tempDir)){
        New-Item $tempDir -ItemType Directory
    }

    Copy-Item $TargetFile $tempDir -Recurse
    &"7z" x $localFile -o"Tmp" *
    Copy-Item $configurationPath $tempDir

    Set-Location -Path $tempDir
    &'.\setup.exe' /IACCEPTSQLSERVERLICENSETERMS /Q `
                /ConfigurationFile=$configFile `
                /SQLSVCPASSWORD="AutodeskVault@26200" `
                /SAPWD="AutodeskVault@26200"
    Set-Location -Path $locationPath

    rm -r $tempDir
}