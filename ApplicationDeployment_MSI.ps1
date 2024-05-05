#Define the path to the MSI package
$Path = ""

#Define the MSI Arguments by using an array.
$MSIArguments = @(
    "/i"
    $Path
    "/quiet"
    "/qn"
    "/norestart"
)

Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow
