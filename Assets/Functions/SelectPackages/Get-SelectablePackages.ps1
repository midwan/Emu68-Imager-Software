function Get-SelectablePackages {
    param (
        [Switch]$PackagesOnly
    )

    $Script:GUIActions.AvailablePackages.Clear()

    $UserSelectablePackageswithSourceLocation = Get-InputCSVs -PackagestoInstall | Where-Object {$_.PackageMandatory -eq 'FALSE'} | Select-Object 'Source','SourceLocation',@{Name='PackageNameUserSelected';Expression = 'PackageNameDefaultInstall'},'PackageNameDefaultInstall','PackageNameFriendlyName','PackageNameGroup','PackageNameDescription' -Unique    
    
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

    # if ($Script:GUICurrentStatus.InstallMediaRequiredFromUserSelectablePackages){
        
    #     if ($Script:GUIActions.FoundInstallMediatoUse){
    #         $HashTableforInstallMedia = @{} # Clear Hash
    #         $Script:GUICurrentStatus.InstallMediaRequiredFromUserSelectablePackages | ForEach-Object {
    #             $HashTableforInstallMedia[$_.SourceLocation]  = @()
    #         }
    #         $NewADFsRequiredFromPackages =  Confirm-RequiredSources | Where-Object {$_.Source -eq 'ADF' -and $_.RequiredFlagUserSelectable -eq 'True'} | Select-Object 'SourceLocation','Source' -Unique
    #         $NewADFsRequiredFromPackages | ForEach-Object {
    #              if (-not ($HashTableforInstallMedia.ContainsKey($_.SourceLocation))){
    #                 $null = Show-WarningorError -BoxTypeWarning -Msg_Header "New Install Media Required" -Msg_Body "Resetting packages to defaults has identified new install media requirements. You will need to re run this check." -ButtonType_OK
    #                 $Script:GUIActions.FoundInstallMediatoUse =$null
    #                 break
    #              }
    #         }

    #     }
 
    # }
   
    $Script:GUICurrentStatus.InstallMediaRequiredFromUserSelectablePackages = Confirm-RequiredSources | Where-Object {$_.Source -eq 'ADF' -and $_.RequiredFlagUserSelectable -eq 'True'} | Select-Object 'SourceLocation','Source' -Unique

}

