$WPF_EditUnicamSettingsWindow_Phase_Input.Add_KeyDown({
    if ($_.Key -eq 'Return'){
        if ((Get-IsValueNumber -TexttoCheck $WPF_EditUnicamSettingsWindow_Phase_Input.Text -IntegerValue) -eq $false){
            $WPF_EditUnicamSettingsWindow_Phase_Input.Background = "Red"
        }
        else {
            if (([int64]$WPF_EditUnicamSettingsWindow_Phase_Input.Text -gt $WPF_EditUnicamSettingsWindow_Phase_Slider.Maximum) -or  ([int64]$WPF_EditUnicamSettingsWindow_Phase_Input.Text -lt $WPF_EditUnicamSettingsWindow_Phase_Slider.Minimum)){
                $WPF_EditUnicamSettingsWindow_Phase_Input.Background = "Yellow"
            }
            else {
                $WPF_EditUnicamSettingsWindow_Phase_Slider.value = $WPF_EditUnicamSettingsWindow_Phase_Input.Text
            }
        }
    }       
})
