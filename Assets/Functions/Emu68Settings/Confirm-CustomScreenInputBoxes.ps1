function Confirm-CustomScreenInputBoxes {
    param (
        $InputBox
    )
    
    # $InputBox = $WPF_CustomScreenModeWindow_Height_Input

    # 
    
    $IsWarning = $false
    
    if ( (Get-IsValueNumber -TexttoCheck $InputBox.Text -IntegerValue) -eq $false) {
        #Write-debug "Invalid"
        $IsWarning = $true
        $InputBox.Background = "Red"
    }
    elseif (([int]$InputBox.Text -eq 0) -or ([int]$InputBox.Text -lt 0)){
        $IsWarning = $true
        $InputBox.Background = "Red"
    } 
    else {
        
        #write-debug "$($InputBox.Name) $([int]$InputBox.Text)"
        if ($InputBox.Name -eq "Height_Input"){
            if (([int]$InputBox.Text -gt 2160) -or  ([int]$InputBox.Text -lt 600)){
                #Write-debug "Matched to Height"
                $IsWarning = $true
                 $InputBox.Background = "Yellow"           
            }
        }
        elseif ($InputBox.Name -eq "Width_Input"){
            if (([int]$InputBox.Text -gt 3840) -or  ([int]$InputBox.Text -lt 800)){
                #Write-debug "Matched to Width"
                $IsWarning = $true
                 $InputBox.Background = "Yellow"              
            }
        }
        elseif ($InputBox.Name -eq "Framerate_Input"){
            if (([int]$InputBox.Text -gt 120) -or  ([int]$InputBox.Text -lt 24)){
                #Write-debug "Matched to Framerate"
                $IsWarning = $true
                 $InputBox.Background = "Yellow"            
            }        
        }
        
    }
    
    if  ($IsWarning -eq $false){
        $InputBox.Background = "#FFFFFFFF"
    }  
        
    return $InputBox.Text
    
}

