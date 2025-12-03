function Get-CVTAspectRatio {
    param (
        $AspectRatio
    )
    
    if ($AspectRatio -eq "4:3") {
        return 1
    }
    elseif ($AspectRatio -eq "14:9") {
        return 2
    }
    elseif ($AspectRatio -eq "16:9") {
        return 3
    }
    elseif ($AspectRatio -eq "5:4") {
        return 4
    }
    elseif ($AspectRatio -eq "16:10") {
        return 5
    }
    elseif ($AspectRatio -eq "15:9") {
        return 6
    }

}





