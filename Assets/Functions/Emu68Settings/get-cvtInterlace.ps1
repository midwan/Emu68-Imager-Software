function get-cvtInterlace {
    param (
        $Interlace
    )
    
    if ($Interlace -eq 'Interlace'){
        return [int]1

    }
    elseif ($Interlace -eq 'Progressive'){
        return [int]0
    }
}