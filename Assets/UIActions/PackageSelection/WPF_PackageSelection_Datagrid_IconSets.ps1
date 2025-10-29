$WPF_PackageSelection_Datagrid_IconSets.add_SelectedCellsChanged({

    if ($Script:GUIActions.SelectedIconSet -ne $WPF_PackageSelection_Datagrid_IconSets.SelectedItem.IconSet){
        if ($Script:GUICurrentStatus.PackagesChanged -ne $true){
            $Script:GUICurrentStatus.PackagesChanged = $true
            $Script:GUICurrentStatus.DefaultPackagesSelected = $false
            if ($Script:GUIActions.FoundInstallMediatoUse){             
                $WPF_PackageSelection_PackageSelection_Label.Text = "You have made changes to the packages and/or icons. You will need to reperform the check for install media."
            }
            $Script:GUIActions.FoundInstallMediatoUse = $null
            Update-UI -PackageSelectionWindow -Emu68Settings
        } 
        $Script:GUIActions.SelectedIconSet = $WPF_PackageSelection_Datagrid_IconSets.SelectedItem.IconSet
        $WPF_PackageSelection_CurrentlySelectedIconSet_Value.text = $WPF_PackageSelection_Datagrid_IconSets.SelectedItem.IconSet
    }     
    
})
