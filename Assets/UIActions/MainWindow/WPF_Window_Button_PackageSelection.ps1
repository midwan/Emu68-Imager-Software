$WPF_Window_Button_PackageSelection.Add_Click({
    if ($Script:GUICurrentStatus.FileBoxOpen -eq $true){
        return
    }

        if (-not ($Script:GUIActions.KickstartVersiontoUse)){
            $null = Show-WarningorError -Msg_Header 'No OS Selected' -Msg_Body 'You cannot select the packages to install or uninstall until you have selected an OS! Please return to this screen after you have selected the OS' -BoxTypeError -ButtonType_OK
            return
        }
    
        if ($Script:GUICurrentStatus.CurrentWindow -ne 'PackageSelection'){
            $Script:GUICurrentStatus.PackagesChanged =$false
        }

        $Script:GUICurrentStatus.CurrentWindow = 'PackageSelection' 
    
        if ($Script:GUICurrentStatus.AvailablePackagesNeedingGeneration -eq $true){
            # Write-debug "Populating Available Packages"
            Get-SelectablePackages 
            $Script:GUICurrentStatus.AvailablePackagesNeedingGeneration = $false
        }
       
        # if (-not ($Script:WPF_PackageSelection)){
        #     $Script:WPF_PackageSelection = Get-XAML -WPFPrefix 'WPF_PackageSelection_' -XMLFile '.\Assets\WPF\Grid_PackageSelection.xaml' -ActionsPath '.\Assets\UIActions\PackageSelection\' -AddWPFVariables
        # }
    
        for ($i = 0; $i -lt $WPF_Window_Main.Children.Count; $i++) {        
            if ($WPF_Window_Main.Children[$i].Name -eq $WPF_Partition.Name){
                $WPF_Window_Main.Children.Remove($WPF_Partition)
            }
            if ($WPF_Window_Main.Children[$i].Name -eq $WPF_StartPage.Name){
                $WPF_Window_Main.Children.Remove($WPF_StartPage)
            }
        }
        
        for ($i = 0; $i -lt $WPF_Window_Main.Children.Count; $i++) {        
            if ($WPF_Window_Main.Children[$i].Name -eq $WPF_PackageSelection.Name){
                $IsChild = $true
                break
            }
        }
        
        if ($IsChild -ne $true){
            $WPF_Window_Main.AddChild($WPF_PackageSelection)
        }
        
        $WPF_PackageSelection_Datagrid_Packages.ItemsSource = $Script:GUIActions.AvailablePackages.DefaultView  
        $WPF_PackageSelection_Datagrid_IconSets.ItemsSource = $Script:GUIActions.AvailableIconSets.DefaultView
        
         if (-not ($WPF_PackageSelection_Datagrid_IconSets.SelectedItem)){
    
             for ($i = 0; $i -lt $Script:GUIActions.AvailableIconSets.DefaultView.Count; $i++) {
                 if ($Script:GUIActions.AvailableIconSets.DefaultView[$i].IconSetDefaultInstall -eq $true){
                     $DefaultRowNumber = $i
                 }
             }  
             
    
             $WPF_PackageSelection_Datagrid_IconSets.SelectedItem = $Script:GUIActions.AvailableIconSets.DefaultView[$DefaultRowNumber]
    
         }
        
        update-ui -MainWindowButtons

})
