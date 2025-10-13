function Update-InputCSV {
    param (
        $GidValue,
        $ExistingCSV,
        $PathtoGoogleDrive_param
    )

    # $GidValue = 322661130
    # $ExistingCSV = '.\InputFiles\ListofPackagestoInstall.CSV'
    # $PathtoGoogleDrive_param = 'https://docs.google.com/spreadsheets/d/12UcKD7INDH9y7Tw_w1q3ebQOUS9JtARIs8Z9JWfLUWg/'
    
    $PathtoGoogleDrive_param = 'https://docs.google.com/spreadsheets/d/12UcKD7INDH9y7Tw_w1q3ebQOUS9JtARIcxcxcxcxcs8Z9JWfLUWg/'
    
    $ExistingCSV_Name = (split-path -leaf -Path $ExistingCSV)

    Write-InformationMessage "Checking for updates to $ExistingCSV_Name"
    if (Test-Path -Path $ExistingCSV){
        $IsExistsInputCSV = $true
        $OldCSV = Get-Content -Path $ExistingCSV 
    }
    else{
        Write-InformationMessage ($ExistingCSV_Name+ ' does not exist!')
        $IsExistsInputCSV = $false
    }

    $PathtoGoogleDrivetouse = "$($PathtoGoogleDrive_param)export?format=tsv&gid=$GidValue"
    $ImportedFile = $null
    
    # $ImportedFile = (((Get-DownloadFile -DownloadURL $PathtoGoogleDrivetouse -NumberofAttempts 3).Content) -split "`r`n")

    $client = [System.Net.Http.HttpClient]::new()
    $client.DefaultRequestHeaders.UserAgent.ParseAdd("PowerShellHttpClient")
    
    $Counter = 0
    $IsSuccess = $null
    
    do {
        $ImportedFile = $client.GetStringAsync($PathtoGoogleDrivetouse).Result -split "`r`n"
        if ($ImportedFile){
            $IsSuccess = $true  
        }
        else {
            Write-InformationMessage -message 'Download failed! Retrying in 3 seconds'
            Start-Sleep -Seconds 3
            $IsSuccess = $false
        }
        $Counter ++              
    } until (
        $IsSuccess -eq $true -or $Counter -eq 3 
    )
    
    # if ($IsSuccess -eq $false){
    #     Write-InformationMessage -Message "Error downloading $ExistingCSV_Name! Using local file! Note, internet connectivity is needed to run the tool!" 
    # }

    If ($ImportedFile){
        $TotalLines = $ImportedFile.Count
    
        $NewCSV = @()
        $Counter = 1
    
        foreach ($Line in $ImportedFile){     
            if ($Counter -lt $TotalLines){
                $NewCSV += @($line -split ("`t"))[0]
            }
            else {
                $NewCSV += @(($line -split ("`t"))[0]).replace("`r`n","")              
            }
            $Counter ++
        }
        if ($IsExistsInputCSV -eq $true){
            if ($NewCSV.Count -ne $OldCSV.Count){
                $IsSame = $false
            }
            else{
                $IsSame = $true
                $LineNumber = 0
                do {
                   if ($OldCSV[$LineNumber] -eq $NewCSV[$LineNumber]){
                    }
                    else {
                        $IsSame = $false
                    }
                    $LineNumber ++
                } until (
                    $IsSame -eq $false -or $LineNumber -gt $OldCSV.Count
                )
            }
        
            if ($IsSame -eq $false){
                Write-InformationMessage "Changes to $ExistingCSV_Name! Updating local file."
                $NewCSV | Out-File -FilePath $ExistingCSV
            }
            else{
                Write-InformationMessage "Local version of $ExistingCSV_Name is up-to-date."
            }
        }
        else{
            Write-InformationMessage "Creating local version of $ExistingCSV_Name"
            $NewCSV | Out-File -FilePath $ExistingCSV
        }
    }
    else {
        Write-InformationMessage -Message "Error Checking $ExistingCSV_Name! Using local file! Note, internet connectivity is needed to run the tool!" 
    }
    
    Write-InformationMessage -Message ""
}