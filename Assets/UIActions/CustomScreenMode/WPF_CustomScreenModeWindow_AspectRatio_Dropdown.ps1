$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.AddChild("4:3")
$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.AddChild("14:9")
$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.AddChild("16:9")
$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.AddChild("5:4")
$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.AddChild("16:10")
$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.AddChild("15:9")
$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.SelectedItem = "16:9"

$WPF_CustomScreenModeWindow_AspectRatio_Dropdown.Add_SelectionChanged({
    $Script:GUIActions.CustomScreenMode_Aspect = $WPF_CustomScreenModeWindow_AspectRatio_Dropdown.SelectedItem 

})