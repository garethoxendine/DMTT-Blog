$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$ImageURL = "https://itpublicstorageaccount.blob.core.windows.net/itpubliccontainer/Screen%20Saver_3.jpg?sp=r&st=2024-11-12T16:46:24Z&se=2030-11-13T00:46:24Z&spr=https&sv=2022-11-02&sr=b&sig=weE%2F5CM9aLkXEY8M0Z3gbGqnUuYLAPTLoR2rQwHaIf0%3D"
$ImagePath = "C:\Truebeck_IT\LockScreen.jpg"

#Download the file and save it to the Truebeck_IT Folder. 
#Check to see if the folder exists; if not, create it. 
if ( Test-Path "C:\Truebeck_IT" ) 
  {}
else
  {
    mkdir "C:\Truebeck_IT"
  }
#Check to see if the wallpaper already exist; if not, download it. 
if ( Test-Path $ImagePath ) 
  {}
else
  {
    Invoke-WebRequest -URI $ImageURL -OutFile $ImagePath
    Start-Sleep -Seconds 10
  }

#Add the registry keys. 
if ( (test-path $RegPath) -eq $False )
{
    New-Item -Path $RegPath -Force
}

if (test-path $RegPath)
{
    $RegPath_Values = get-itemproperty -path $RegPath
    if ($RegPath_Values -match "LockScreenImage")
    {
        $Value = get-itempropertyvalue -Path $RegPath -Name LockScreenImage
        If ($Value.Equals($ImagePath))
        {}
        Else
        {
            set-itemproperty -Path $RegPath -Name LockScreenImage -Value $ImagePath -Type String -Force
        }
    }
    else 
    {
        set-itemproperty -Path $RegPath -Name LockScreenImage -Value $ImagePath -Type String -Force
    }

    if ($RegPath_Values -match "NoChangingLockScreen")
    {
        $Value = get-itempropertyvalue -Path $RegPath -Name NoChangingLockScreen
        If ($Value.Equals(1))
        {}
        Else
        {
            set-itemproperty -Path $RegPath -Name NoChangingLockScreen -Value "1" -Type DWORD -Force
        }
    }
    else 
    {
        set-itemproperty -Path $RegPath -Name NoChangingLockScreen -Value "1" -Type DWORD -Force
    }
}
# SIG # Begin signature block
# MIIJmwYJKoZIhvcNAQcCoIIJjDCCCYgCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCPl6kx438XeyQr
# zGFE7Muf0++kkgjrvoRYoxXrVgGFQ6CCBuEwggbdMIIExaADAgECAhMSAAAYRRrM
# hdPLmsZmAAAAABhFMA0GCSqGSIb3DQEBCwUAMEcxEzARBgoJkiaJk/IsZAEZFgNj
# b20xGDAWBgoJkiaJk/IsZAEZFghUcnVlYmVjazEWMBQGA1UEAxMNVHJ1ZWJlY2tD
# ZXJ0czAeFw0yMzA4MjQxNzE5MTVaFw0yNTA4MjQxNzI5MTVaMB4xHDAaBgNVBAMT
# E1RydWViZWNrIENvZGVTaWduZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
# AoIBAQDCINy1nhCNNKgkJdfZPc0p6BYlRRThpEORpX5WrIjYsiBB8QeExy/lzLKl
# l/EIkGUeFaWUYAjAr7ddXIxzi8kPV41qEgz/90F9HiB8egjBuuft09YTf2MScvF8
# 54WHApSqFmyRGR+2O6YTWvM+vp13rofqGWyfn3Hekkf0kkTaCeGQkzlagf4HkqZ8
# wrr1NSzd9wPy88TvlNiBZKpUGbU8o8ZdVC+G3rhv0chhQzqgQqSpMQ6/iIHrN6qU
# VP0KwfJb9NKdCToThnpf0fS/L+3XWJ1L4Sm4ncNhI0mJ0xQU221VhpNrwttMFzVL
# tIk0912R/KXjCc3Pnn5OIfVFGj5xAgMBAAGjggLpMIIC5TA9BgkrBgEEAYI3FQcE
# MDAuBiYrBgEEAYI3FQiCtLRQh/ySA4eVnR+Ek69phfScMDCD+IAHhLjRfwIBZAIB
# CzATBgNVHSUEDDAKBggrBgEFBQcDAzAOBgNVHQ8BAf8EBAMCB4AwGwYJKwYBBAGC
# NxUKBA4wDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUn3W+ItwbA1ZzSqtAMP3uwf/P
# zjswHwYDVR0jBBgwFoAUCmeCkJhw9AUBYRMXKqABJojdNuUwgdEGA1UdHwSByTCB
# xjCBw6CBwKCBvYaBumxkYXA6Ly8vQ049VHJ1ZWJlY2tDZXJ0cyxDTj1UQy1TVlIt
# Q2VydHMsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
# Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9VHJ1ZWJlY2ssREM9Y29tP2NlcnRpZmlj
# YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRp
# b25Qb2ludDCBwAYIKwYBBQUHAQEEgbMwgbAwga0GCCsGAQUFBzAChoGgbGRhcDov
# Ly9DTj1UcnVlYmVja0NlcnRzLENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
# aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPVRydWViZWNrLERD
# PWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlv
# bkF1dGhvcml0eTA7BgNVHREENDAyoDAGCisGAQQBgjcUAgOgIgwgVHJ1ZWJlY2su
# Q29kZVNpZ25lckBUcnVlYmVjay5jb20wTgYJKwYBBAGCNxkCBEEwP6A9BgorBgEE
# AYI3GQIBoC8ELVMtMS01LTIxLTIzODY2MTAzNDQtOTYzMTc2NDMtMTMwMzIwNzc5
# NC0yNzIwMDANBgkqhkiG9w0BAQsFAAOCAgEAEXy+QmTUYFIXoFNaoUwqsvw7/J1e
# bXSA6ZqJSqINGcyp51tsxMCXaR098hpameXJoBZm9xtREc14BGs+jggtSvqNdTVe
# IrU0CotSBevp+eyD39PTipYr9W3Ft/We0EHyPoNCM8XiVf450/RrclkDW++Rn+Uu
# DlzYXxvvucb+NbMYm47OD0hN2TvNxKjhXTM2KW/H7qtGwU4xrM451GULPA4EKemm
# 4Cx5Kv2dXE7rBzefLqtttO8VajvdQ7I0fY/My1Pto4ID+/w9CPbXW6cqPeSbl2uC
# 1ZZEzLUnw15VDJSLPuNK2svkIc5/Pi6mKGWFs5DjbAlL3cD/PmttDLWOpPkpFR+X
# dBjiknFfs3IY4p5laDdYilqSgcFAp/CpOvSAhZznzwoWRUGUb4CpDVIJNQ/SJpRV
# KkdOM+ndyC/MYQ+p5Od1KDHx+napX84bp01NcbB45nHnJnduGU9yoxgY07HERZtQ
# QJmn6f9h12EzdMntg7pjgTeoA9FoiZI3zpGzC5VoBNbIF8tA1CPoc7Xij9bAjLGV
# FUjfY8M4FumhEXuprSp4FwiN2NvnojRtVprxbAOT0+FjO8mGCtGyJCzhJ9aOBT0x
# lDnxH8wSbCnx6au0MrdNo8KJ36hTo34eAe4m3uAkL0blSmZspMiMEBKibpxZTz8z
# 3IJm6QiCYeVAJQ8xggIQMIICDAIBATBeMEcxEzARBgoJkiaJk/IsZAEZFgNjb20x
# GDAWBgoJkiaJk/IsZAEZFghUcnVlYmVjazEWMBQGA1UEAxMNVHJ1ZWJlY2tDZXJ0
# cwITEgAAGEUazIXTy5rGZgAAAAAYRTANBglghkgBZQMEAgEFAKCBhDAYBgorBgEE
# AYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwG
# CisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCArxQJx
# 1aBgLbaBl8QwwihpjuyepSTK2OhF3kutNXmNOTANBgkqhkiG9w0BAQEFAASCAQBY
# yLq5GttEJMku/K+zpDsaDse6f73Y4FTFNpvyXMHI47+yQFrj1CAqPR+x+TXmBoJF
# hLhCq7XpEaXpNMVi6AgiIrgj+NeUrftveB/T4qMDNNRij3m9U7HB6cnB7nNh3UmD
# 7iMu0+/zBDS+DeDWPo0SOtfWEc7vHBgl56l2lErvrHYrTerX+/ZKlEFAjD7vrPMt
# ZwNt2VU7Lz8givhN7K42LTgX/3OG1tz6ECMLi5XNAl5+gZS8bCHNVLpMKop/enYf
# k3Ay5B0JmphKa3giNpOCLMSZjbAVWXJquBuytbpcQcvtoK06j4UZMlR1MxvCare3
# U5fTKz39FI4OJYGCFE5l
# SIG # End signature block
