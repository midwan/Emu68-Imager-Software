function Confirm-CustomScreenModeComplete {
    param (
        
    )
    
    $IsWarning = $false

    If (($Script:GUIActions.CustomScreenMode_Width) -and ($Script:GUIActions.CustomScreenMode_Height) -and ($Script:GUIActions.CustomScreenMode_Framerate)){
        if (([int]$Script:GUIActions.CustomScreenMode_Height -gt 2160) -or  ([int]$Script:GUIActions.CustomScreenMode_Height -lt 600)){
            $IsWarning = $true
        }
        if (([int]$Script:GUIActions.CustomScreenMode_Width -gt 3840) -or  ([int]$Script:GUIActions.CustomScreenMode_Width -lt 800)){
            $IsWarning = $true
        }
        if (([int]$Script:GUIActions.CustomScreenMode_Framerate -gt 120) -or  ([int]$Script:GUIActions.CustomScreenMode_Framerate -lt 24)){
            $IsWarning = $true
        }            
            
        if ($IsWarning -eq $True) {
            return "Warning"
        }
        else {
            return "Complete"
        }
    }
    else {
        return "Incomplete"
        
    }

}
