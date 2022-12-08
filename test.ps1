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
   
                      }
  