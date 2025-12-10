$WPF_StartPage_CustomScreenMode_button.Add_Click({
    Remove-Variable -Name 'WPF_CustomScreenModeWindow_*'
    $WPF_CustomScreenModeWindow = Get-XAML -WPFPrefix 'WPF_CustomScreenModeWindow_' -XMLFile '.\Assets\WPF\Window_CustomResolution.xaml'  -ActionsPath '.\Assets\UIActions\CustomScreenMode\' -AddWPFVariables
   
    $IsError = $false

    If ($Script:GUIActions.CustomScreenMode_Width){
        $WPF_CustomScreenModeWindow_Width_Input.Text = $Script:GUIActions.CustomScreenMode_Width
    }
    else {
        $IsError = $true
    }
    If ($Script:GUIActions.CustomScreenMode_Height){
        $WPF_CustomScreenModeWindow_Height_Input.Text = $Script:GUIActions.CustomScreenMode_Height        
    }
    else {
        $IsError = $true
    }
    If ($Script:GUIActions.CustomScreenMode_Framerate){
        $WPF_CustomScreenModeWindow_Framerate_Input.Text = $Script:GUIActions.CustomScreenMode_Framerate       
    }
    else {
        $IsError = $true
    }    
    If ($Script:GUIActions.CustomScreenMode_Aspect){
        $WPF_CustomScreenModeWindow_AspectRatio_Dropdown.SelectedItem = $Script:GUIActions.CustomScreenMode_Aspect
        
    }
    If ($Script:GUIActions.CustomScreenMode_Margins -eq 'Enabled'){
        $WPF_CustomScreenModeWindow_MarginsEnabled_radioButton.IsChecked = 1        
    }
    elseIf ($Script:GUIActions.CustomScreenMode_Margins -eq 'Disabled'){
        $WPF_CustomScreenModeWindow_MarginsDisabled_radioButton.IsChecked = 1        
    }
    If ($Script:GUIActions.CustomScreenMode_Interlace -eq "Interlace"){
        $WPF_CustomScreenModeWindow_Interlace_radioButton.IsChecked = 1
    }
    elseIf ($Script:GUIActions.CustomScreenMode_Interlace -eq "Progressive"){
        $WPF_CustomScreenModeWindow_Progressive_radioButton.IsChecked = 1
    }    
    If ($Script:GUIActions.CustomScreenMode_RB -eq "Normal"){
        $WPF_CustomScreenModeWindow_NormalBlanking_radioButton.IsChecked = 1
    }
    elseIf ($Script:GUIActions.CustomScreenMode_RB -eq "Reduced"){
        $WPF_CustomScreenModeWindow_ReducedBlanking_radioButton.IsChecked = 1
    
    }

    if ($IsError -eq $true) {
        $Script:GUIActions.CustomScreenMode_Width = $null
        $Script:GUIActions.CustomScreenMode_Height = $null    
        $Script:GUIActions.CustomScreenMode_Framerate = $null       
        $WPF_CustomScreenModeWindow_Height_Input.Text = $Script:GUIActions.CustomScreenMode_Height 
        $WPF_CustomScreenModeWindow_Framerate_Input.Text = $Script:GUIActions.CustomScreenMode_Framerate      
        $WPF_CustomScreenModeWindow_Width_Input.Text = $Script:GUIActions.CustomScreenMode_Width     
        $WPF_CustomScreenModeWindow_ErrorMessage_Label.Text = "One or more custom values have not been entered! No valid screenmode defined."
    }

    $WPF_CustomScreenModeWindow.ShowDialog() | out-null   
    $WPF_CustomScreenModeWindow.close()

})



