#ASP.NET 4.0 registered with IIS
function ASPNETRegistered{
    $locationPath=Get-Location
    $commandPath="c:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\"

    Set-Location -Path $commandPath
    ./aspnet_regiis.exe -i
    Set-Location -Path $locationPath
}
