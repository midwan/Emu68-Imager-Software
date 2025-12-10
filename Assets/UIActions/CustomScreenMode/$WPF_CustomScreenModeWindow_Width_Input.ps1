$WPF_CustomScreenModeWindow_Width_Input.Add_KeyDown({
    if ($_.Key -eq 'Return'){
        
        $IsError = $false

        $Script:GUIActions.CustomScreenMode_Height = Confirm-CustomScreenInputBoxes -InputBox $WPF_CustomScreenModeWindow_Height_Input 
        $Script:GUIActions.CustomScreenMode_Width = Confirm-CustomScreenInputBoxes -InputBox $WPF_CustomScreenModeWindow_Width_Input 
        $Script:GUIActions.CustomScreenMode_Framerate = Confirm-CustomScreenInputBoxes -InputBox $WPF_CustomScreenModeWindow_Framerate_Input
        
        $CompletenessCheck = Confirm-CustomScreenModeComplete

        if ($CompletenessCheck -eq "Incomplete"){
            $WPF_CustomScreenModeWindow_ErrorMessage_Label.Text = "One or more custom values have not been entered! No valid screenmode defined."
        }
        elseif  ($CompletenessCheck -eq "Warning"){
            $WPF_CustomScreenModeWindow_ErrorMessage_Label.Text = "One or more values are not in range! No valid screenmode defined."
        }
        else {
            $WPF_CustomScreenModeWindow_ErrorMessage_Label.Text = ""
        }

    }
})