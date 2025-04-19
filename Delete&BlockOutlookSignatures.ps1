#DELETE EXISTING SIGNATURES
#Delete the contents of the Signature folder if it exists. 
$SignatureFolder = "C:\Users\$env:username\appdata\Roaming\Microsoft\Signatures"

if ( test-path $SignatureFolder )
{
    $Contents = get-childitem -Path $SignatureFolder
    foreach ($File in $Contents)
    {
       $File | remove-item -Recurse -Force
    }
}

#BLOCK THE CREATION OF NEW SIGNATURES
#Add the registry keys if they do not already exist. 
$RegKeyPath1 = "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\mailsettings"
$RegKeyPath2 = "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" 

if ( test-path $RegKeyPath1 )
{
    $RegKeyPath1_Values = get-itemproperty -path $RegKeyPath1
    
    if ($RegKeyPath1_Values -match "disablesignatures")
    {
        $Value = get-itempropertyvalue -Path $RegKeyPath1 -Name disablesignatures
        If ($Value.Equals(1))
        {}
        Else
        {
            set-itemproperty -Path $RegKeyPath1 -Name disablesignatures -Value "1" -Type DWORD -Force
        }
    }
    else 
    {
        set-itemproperty -Path $RegKeyPath1 -Name disablesignatures -Value "1" -Type DWORD -Force
    }
}
Elseif ( Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\Common" )
{
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\Common" -Name "mailsettings"
    set-itemproperty -Path $RegKeyPath1 -Name disablesignatures -Value "1" -Type DWORD -Force
}
Else{}

if ( test-path $RegKeyPath2 )
{
    $RegKeyPath2_Values = get-itemproperty -path $RegKeyPath2
    
    if ($RegKeyPath2_Values -match "disablesignatures")
    {
        $Value = get-itempropertyvalue -Path $RegKeyPath2 -Name disablesignatures
        If ($Value.Equals(1))
        {}
        Else
        {
            set-itemproperty -Path $RegKeyPath2 -Name disablesignatures -Value "1" -Type DWORD -Force
        }
    }
    else 
    {
        set-itemproperty -Path $RegKeyPath2 -Name disablesignatures -Value "1" -Type DWORD -Force
    }
}
Elseif ( test-path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" )
{
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "mailsettings"
    set-itemproperty -Path $RegKeyPath2 -Name disablesignatures -Value "1" -Type DWORD -Force
}
Else{}
