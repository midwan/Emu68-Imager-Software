# $AvailableScreenModes = Import-Csv ($InputFolder+'ScreenModes.csv') -delimiter ';' | Where-Object 'Include' -eq 'TRUE'

$Script:GUIActions.AvailableScreenModes = Get-InputCSVs -ScreenModes

foreach ($ScreenMode in $Script:GUIActions.AvailableScreenModes) {
    $WPF_StartPage_ScreenMode_Dropdown.AddChild($ScreenMode.FriendlyName)
}

$Script:GUIActions.ScreenModetoUseFriendlyName = 'Automatic'
$WPF_StartPage_ScreenMode_Dropdown.SelectedItem = $Script:GUIActions.ScreenModetoUseFriendlyName 
$Script:GUIActions.ScreenModetoUse = 'Auto'

$WPF_StartPage_ScreenMode_Dropdown.Add_SelectionChanged({
    foreach ($ScreenMode in $Script:GUIActions.AvailableScreenModes ) {
        if ($ScreenMode.FriendlyName -eq $WPF_StartPage_ScreenMode_Dropdown.SelectedItem){
            $Script:GUIActions.ScreenModetoUse = $ScreenMode.Name
            $Script:GUIActions.ScreenModetoUseFriendlyName = $WPF_StartPage_ScreenMode_Dropdown.SelectedItem           
        }
    }

     $null = Update-UI -Emu68Settings
    
})