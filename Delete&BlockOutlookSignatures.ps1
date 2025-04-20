#DELETE EXISTING SIGNATURES
#Delete the contents of the Signature folder If it exists. 
$SignatureFolder = "C:\Users\$env:username\appdata\Roaming\Microsoft\Signatures"

If ( Test-Path $SignatureFolder )
{
    $Contents = Get-Childitem -Path $SignatureFolder
    foreach ($File in $Contents)
    {
       $File | Remove-Item -Recurse -Force
    }
}

#BLOCK THE CREATION OF NEW SIGNATURES
#Add the registry keys if they do not already exist. 
$RegKeyPath1 = "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\mailsettings"
$RegKeyPath2 = "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\MailSettings" 

If ( Test-Path $RegKeyPath1 )
{
    $RegKeyPath1_Values = Get-ItemProperty -path $RegKeyPath1
    
    If ($RegKeyPath1_Values -match "disablesignatures")
    {
        $Value = Get-ItemPropertyValue -Path $RegKeyPath1 -Name disablesignatures
        If ($Value.Equals(1))
        {}
        Else
        {
            Set-ItemProperty -Path $RegKeyPath1 -Name disablesignatures -Value "1" -Type DWORD -Force
        }
    }
    Else 
    {
        Set-ItemProperty -Path $RegKeyPath1 -Name disablesignatures -Value "1" -Type DWORD -Force
    }
}
ElseIf ( Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\Common" )
{
    New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\Common" -Name "mailsettings"
    Set-ItemProperty -Path $RegKeyPath1 -Name disablesignatures -Value "1" -Type DWORD -Force
}
Else{}

If ( Test-Path $RegKeyPath2 )
{
    $RegKeyPath2_Values = Get-ItemProperty -path $RegKeyPath2
    
    If ($RegKeyPath2_Values -match "disablesignatures")
    {
        $Value = Get-ItemPropertyValue -Path $RegKeyPath2 -Name disablesignatures
        If ($Value.Equals(1))
        {}
        Else
        {
            Set-ItemProperty -Path $RegKeyPath2 -Name disablesignatures -Value "1" -Type DWORD -Force
        }
    }
    Else 
    {
        Set-ItemProperty -Path $RegKeyPath2 -Name disablesignatures -Value "1" -Type DWORD -Force
    }
}
ElseIf ( Test-Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" )
{
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "mailsettings"
    Set-ItemProperty -Path $RegKeyPath2 -Name disablesignatures -Value "1" -Type DWORD -Force
}
Else{}
