$WPF_StartPage_Password_Textbox.add_LostFocus({
    if ($WPF_StartPage_Password_Textbox.Text){
        $Script:GUIActions.WifiPassword = $WPF_StartPage_Password_Textbox.Text
    }
})

