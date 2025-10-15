function Write-StartTaskMessage {
    param (
    )
    Write-Host ''
    Write-Host "[Section: $($Script:Settings.CurrentTaskNumber) of $($Script:Settings.TotalNumberofTasks)]: `t Starting Task: $($Script:Settings.CurrentTaskName)" -ForegroundColor White
    Write-Host ''
    '' | Out-File $Script:Settings.LogLocation -Append -Encoding utf8
    "[Section: $($Script:Settings.CurrentTaskNumber) of $($Script:Settings.TotalNumberofTasks)]: `t Starting Task: $($Script:Settings.CurrentTaskName)" | Out-File $Script:Settings.LogLocation -Append -Encoding utf8
    '' | Out-File $Script:Settings.LogLocation -Append -Encoding utf8
}



