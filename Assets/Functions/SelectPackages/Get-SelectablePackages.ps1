function Get-SelectablePackages {
    param (
        [Switch]$PackagesOnly
    )

    $Script:GUIActions.AvailablePackages.Clear()

    $UserSelectablePackageswithSourceLocation = Get-InputCSVs -PackagestoInstall | Where-Object {$_.PackageType -eq 'Selectable' -and (($_.NetworkStack -eq "Any") -or ($_.NetworkStack -eq  $Script:GUIActions.NetworkStack))} | Select-Object 'Source','SourceLocation',@{Name='PackageNameUserSelected';Expression = 'PackageNameDefaultInstall'},'PackageNameDefaultInstall','PackageNameFriendlyName','PackageNameGroup','PackageNameDescription' -Unique    
    
    $HashTableforInstallMedia = @{} # Clear Hash

    $UserSelectablePackageswithSourceLocation | ForEach-Object {
        if ($_.Source -eq 'ADF'){
            $HashTableforInstallMedia[$_.PackageNameFriendlyName] = @('ADF') 
            
        }
    }
    
    $DatatoPopulate = $UserSelectablePackageswithSourceLocation | Select-Object 'PackageNameUserSelected','PackageNameDefaultInstall','PackageNameFriendlyName','PackageNameGroup','PackageNameDescription' -Unique 
    
    $DatatoPopulate | Add-Member -NotePropertyName 'InstallMediaFlag' -NotePropertyValue $null
    
    $DatatoPopulate | ForEach-Object {
         if ($HashTableforInstallMedia.ContainsKey($_.PackageNameFriendlyName)){
            $_.InstallMediaFlag = $true
         }
         else {
            $_.InstallMediaFlag = $false
         }
    }
  
    foreach ($line in $DatatoPopulate){
        $Array = @()
        $array += $line.PackageNameUserSelected
        $array += $line.PackageNameDefaultInstall
        $array += $line.PackageNameFriendlyName
        $array += $line.PackageNameGroup
        $array += $line.PackageNameDescription
        $array +=$line.InstallMediaFlag
        [void]$Script:GUIActions.AvailablePackages.Rows.Add($array)
    }

    If (-not ($PackagesOnly)){ 
        Write-AvailableIconsets

    }

    $Script:GUICurrentStatus.AvailablePackagesNeedingGeneration = $false

    $Script:GUICurrentStatus.InstallMediaRequiredFromUserSelectablePackages = Confirm-RequiredSources | Where-Object {$_.Source -eq 'ADF' -and $_.RequiredFlagUserSelectable -eq 'True'} | Select-Object 'SourceLocation','Source' -Unique

}

