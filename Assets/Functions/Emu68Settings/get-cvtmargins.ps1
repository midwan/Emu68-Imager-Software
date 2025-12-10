function get-cvtMargins {
    param (
        $Margins
    )
    
    if ($Margins -eq 'Disabled'){
        return [int]0

    }
    elseif ($Margins -eq 'Enabled'){
        return [int]1
    }
}