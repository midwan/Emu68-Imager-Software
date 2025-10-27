$WPF_PackageSelection_ResettoDefault.Add_Click({
    if ((Show-WarningorError -BoxTypeQuestion -Msg_Header "Confirm reset of packages" -Msg_Body "Are you sure you want to reset the packages to the default?" -ButtonType_YesNo) -eq "Yes"){
        if ($Script:GUIActions.FoundInstallMediatoUse){
            $WPF_PackageSelection_PackageSelection_Label.Text = "You have made changes to the packages and/or icons. You will need to reperform the check for install media."
        }
        $Script:GUIActions.FoundInstallMediatoUse = $null
        Update-UI -PackageSelectionWindow -Emu68Settings
        Get-SelectablePackages -PackagesOnly
        
    }
})
