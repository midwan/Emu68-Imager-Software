function get-cvtBlanking {
    param (
        $RB
    )
    
    if ($RB -eq 'Normal'){
        return [int]0

    }
    elseif ($RB -eq 'Reduced'){
        return [int]1
    }
}