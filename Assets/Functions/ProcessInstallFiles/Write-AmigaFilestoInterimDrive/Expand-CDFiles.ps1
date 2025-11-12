function Expand-CDFiles {
    param (
        [Switch]$SevenZip,
        [Switch]$HSTImager,
        $InputFile,
        $OutputDirectory,
        $FiletoExtract
    )
    
    if ($SevenZip){
        $TempFoldertoExtract = "$($Script:Settings.TempFolder)\CDFilesSevenZip\"
    }

    if ($HSTImager){
        $TempFoldertoExtract = "$($Script:Settings.TempFolder)\CDFilesHSTImager\"
    }

    if (-not (Test-Path $TempFoldertoExtract)){
        $null = New-Item $TempFoldertoExtract -ItemType Directory -Force
    }
    
    $ParentFolder = $FiletoExtract.split("\")[0]
    $ExtractedFilesPath = "$TempFoldertoExtract$ParentFolder"
    
    if (-not (Test-path $ExtractedFilesPath)){
        Write-InformationMessage -Message "No existing extracted files. Extracting $ParentFolder"
        if ($SevenZip){
            $TempFoldertoUse = [System.IO.Path]::GetFullPath($Script:Settings.TempFolder)
            & $Script:ExternalProgramSettings.SevenZipFilePath x ('-o'+$TempFoldertoExtract) $InputFile $ParentFolder -y >($TempFoldertouse+'LogOutputTemp.txt')
    
            if ($LASTEXITCODE -ne 0) {
                Write-ErrorMessage -Message ('Error extracting '+$InputFile+'! Cannot continue!')
                return $false    
            }
        }
        if ($HSTImager){
            $TempFoldertoExtract = [System.IO.Path]::GetFullPath($TempFoldertoExtract)
            $Commandtouse = [PSCustomObject]@{
                Command = "fs extract `"$InputFile\*`" `"$TempFoldertoExtract`" --uaemetadata None --recursive TRUE --makedir TRUE"
            }
                
            Start-HSTCommands -HSTScript $Commandtouse -TotalSteps 7609 -ActivityDescription "Running HST Imager to extract OS files"            
        }
    } 


}