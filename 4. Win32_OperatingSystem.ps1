# Get the Win32_OperatingSystem WMI class
$os = Get-WmiObject -Class Win32_OperatingSystem

# Extract the operating system parameters
$osName = $os.Name
$OsVersion = $os.Version
$bootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime


# Print the operating system name to the console
Write-Output "Operating System Name: $osName"
Write-Output "Operating System Version: $osVersion"
write-Output "The computer last booted up at: $bootTime"
Get-PSDrive -Name C

function Get-FreeSpaceOnC {
    # Get the computer name
    $ComputerName = Read-Host "Enter the computer name"
    # Get the FreeSpace on C:
    $FreeSpace = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $ComputerName -Filter "DeviceID='C:'" | Select-Object FreeSpace
    # Return the FreeSpace value
    Return $FreeSpace.FreeSpace
}

# Call the function
$FreeSpace = Get-FreeSpaceOnC
$freeSpaceGB = $FreeSpace / 1gb -as [int]
Write-Host "The free space on C: is $FreeSpaceGB" -ForegroundColor Cyan



# Define the Get-FreeSpace function
function Get-HostInfo {
    [cmdletbinding()]
    param(
    [Parameter(Mandatory = $true, ValueFromPipeLine = $true, ValueFromPipelineByPropertyName = $true)]
      [string[]]$DNSHost
    )
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $bootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $drive = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $DNSHost -Filter "DeviceID='C:'"
    $freeSpace = $drive.FreeSpace
    $freeSpaceGB = $freeSpace / 1GB
  
    $properties = [ordered]@{
                      'HostName' = $DNSHost;
                      'OS'       = $OS.Caption;
                      'LastBootTime' = $os.LastBootUpTime;
                      'Uptime' = $uptime;
                      'C_GB_Free' = ($Drivespace.freespace / 1GB -as [int])
                              }
              $Obj = New-Object -TypeName PSObject -Property $properties
            $obj | Select-Object -Property hostname, OS, Lastboottime, Uptime, C_GBFree | Export-Csv Path C:\csv.csv -NoTypeInformation -Append   




function Get-HostInfo
{
    [cmdletbinding()]
    [Parameter(Mandatory = $true, ValueFromPipeLine = $true, ValueFromPipelineByPropertyName = $true)]
    param(
        [string[]]$DnsHost,
        [string]$DriveLetter
    )

    foreach ($DnsHost in $DnsHost)
    {
        $objWMIService = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $DNShost
        $objDrive = $objWMIService | Where-Object {$_.DeviceID -eq "$($DriveLetter):"}

        Write-Output "Free space on $($DriveLetter): drive on $DnsHost : $($objDrive.FreeSpace) bytes"
    }
}


# Define the Get-FreeSpace function
function Get-HostInfo {
    [cmdletbinding()]
    param(
    [Parameter(Mandatory = $true, ValueFromPipeLine = $true, ValueFromPipelineByPropertyName = $true)]
      [string[]]$DNSHost
    )
  
    PROCESS{
    FOREACH($DNSHost in $DNSHost){
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $bootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $drive = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $DNSHost -Filter "DeviceID='C:'"
    $freeSpace = $drive.FreeSpace
    $freeSpaceGB = $freeSpace / 1GB
  
    $properties = [ordered]@{
                      'HostName' = $DNSHost;
                      'OS'       = $OS.Caption;
                      'LastBootTime' = $os.LastBootUpTime;
                      'Uptime' = $uptime;
                      'FreeSpaceGB' = ($Drivespace.freespace / 1GB -as [int])
                              }
                                 }
             }
   $HostObj = New-Object -TypeName PSObject -Property $properties
   
                      }
  