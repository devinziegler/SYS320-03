. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$prompt += "9 - Get At Risk Users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"

        $chkUser = checkUser $name
        if($chkUser -ne $false) {
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
            $btsr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $plainpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($btsr)

            $chkPasswd = checkPassword $plainpassword;
            if($chkPasswd -ne $false) {
                createAUser $name $password
                Write-Host "User: $name is created." | Out-String
            }
            else{Write-Host "Password should be more than 5 characters and include at least 1 etc." | Out-String}
        }
        else{
            Write-Host "user $name already exists." | Out-String 
        } 
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        $chkUser = checkUser $name
        if($chkUser -ne $true) {
            removeAUser $name
            Write-Host "User: $name Removed" | Out-String
        }
        else { 
            Write-Host "User does not exist."
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $chkUser = checkUser $name
        if($chkUser -ne $true) {
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else {
            Write-Host "User does not exist."
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.

        $chkUser = checkUser $name
        if($chkUser -ne $true) {
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else {
            Write-Host "User does not exist."
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        $chkUser = checkUser $name
        if($chkUser -ne $true) {
            $timeSince = Read-Host -Prompt "Please enter the number of days to search back."
            $userLogins = getLogInAndOffs $timeSince

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{ 
            Write-Host "User does not exist."
        }
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        $chkUser = checkUser $name 
        if ($chkUser -ne $true) {
            $timeSince = Read-Host -Prompt "Please enter the number to days to search back."
            $userLogins = getFailedLogins $timeSince

            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
            
        }
        else {
            Write-Host "User does not exist."
        }  
    }

    elseif($choice -eq 9){
        $timeSince = Read-Host -Prompt "Please enter the number to days to search back."
        $atRiskUsers = getAtRiskUsers $timeSince
        if ($atRiskUsers.Count -eq 0) {
            Write-Output "There are not at risk users."
        }
        else{
            $atRiskUsers | Format-Table | Out-String
        }

    }

    elseif($choice -notmatch '^[0 - 9]$') {
        Write-Host "Enter a listed option"
    }

}




