# $Script:GUIActions.AvailableScreenModesWB = Get-InputCSVs -ScreenModesWB
# foreach ($ScreenMode in $Script:GUIActions.AvailableScreenModesWB) {
#     $WPF_StartPage_ScreenModeWorkbench_Dropdown.AddChild($ScreenMode.FriendlyName)
# }

$WPF_StartPage_ScreenModeWorkbench_Dropdown.Add_SelectionChanged({
    if (($WPF_StartPage_ScreenModeWorkbench_Dropdown.SelectedItem) -and ($WPF_StartPage_ScreenModeWorkbench_Dropdown.SelectedItem -ne "You need to configure the custom screenMode first!")) {
        if ($WPF_StartPage_ScreenModeWorkbench_Dropdown.SelectedItem -ne $Script:GUIActions.ScreenModetoUseWB){
            $Script:GUIActions.ScreenModetoUseWB = $WPF_StartPage_ScreenModeWorkbench_Dropdown.SelectedItem
            update-ui -WBScreenModeUpdate -Emu68Settings
        }
    }
}) 