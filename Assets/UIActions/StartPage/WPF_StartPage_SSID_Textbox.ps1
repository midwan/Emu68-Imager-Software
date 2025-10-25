$WPF_StartPage_SSID_Textbox.add_LostFocus({
    if ($WPF_StartPage_SSID_Textbox.Text){
        $Script:GUIActions.SSID = $WPF_StartPage_SSID_Textbox.Text    
    }    
})
