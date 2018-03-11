# Setup Administrator user and password
function SetupAdminUser{
    
    $username = "user_name"
    $password = "password"
    if (Get-WmiObject Win32_UserAccount -Filter "LocalAccount='true' and Name='vaultadmin'") {
      net user $username $password
      wmic useraccount where "Name='$username'" set disabled=false
    } else {
      net user $username $password /add
      net localgroup Administrators $username /add
    }
    wmic useraccount where "Name='$username'" set PasswordExpires=false
}
