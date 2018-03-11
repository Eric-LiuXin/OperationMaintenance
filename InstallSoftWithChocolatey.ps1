# Install chocolatey
function InstallChocolatey{
    $chocoPath = $env:chocolateyinstall
    if ($chocoPath -eq $null -or $chocoPath -eq '' -or !(Test-Path($chocoPath))) {
      Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

# Install 7zip
function Install7zip{
    $result = clist -lo -e 7zip
    if ("$result" -match ".* (\d+) packages installed.") {
      if ($matches[1] -eq 0) {
        cinst -y 7zip --timeout 0
        $changed = $True
      }
    }

    # Add 7zip to system path
    $path = [environment]::GetEnvironmentvariable("Path","Machine")
    if (-not ($path -match ".*7-Zip")){
        $path = $path + ";C:\Program Files\7-Zip"
        [environment]::SetEnvironmentvariable("Path", $path, "Machine")
    }
}

# Install powershell 4
function InstallPowershell4{
    if ($PSVersionTable.PSVersion.Major -lt 4) {
      cinst -y powershell4
      $changed = $True
    }
}
