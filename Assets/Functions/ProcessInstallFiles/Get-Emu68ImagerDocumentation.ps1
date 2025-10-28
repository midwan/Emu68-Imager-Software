function Get-Emu68ImagerDocumentation {
    param (
        $LocationtoDownload
    )

   # $LocationtoDownload ='E:\PiStorm\Docs\'
    $DownloadURLs = Get-InputCSVs -DocumentationURLs
    $AssetsNotDownloaded = 0

    foreach ($URLLine in $DownloadURLs){
        
        If (([System.IO.Path]::GetExtension("$(Split-Path $URLLine.URL -Leaf)")) -eq ".png"){
            $DownloadType = "Picture"
            $OutfileLocation = "$($LocationtoDownload)images\"
        }
        else {
            $DownloadType = "Page"
            If ((Split-Path $URLLine.URL -Leaf) -eq 'index.html'){
                $OutfileLocation = $LocationtoDownload 
            }
            else {
                $OutfileLocation = "$($LocationtoDownload)html\"
            }
        }        

        if (-not (test-path $OutfileLocation)){
                $null = New-Item $OutfileLocation -ItemType Directory
        }
    
        #Write-debug "Downloading file: $($URLLine.URL) to $OutfileLocation$(Split-Path $URLLine.URL -Leaf)"
        
        if ((Get-DownloadFile -DownloadURL $URLLine.URL -OutputLocation "$OutfileLocation$(Split-Path $URLLine.URL -Leaf)" -NumberofAttempts 2) -eq $true){
            if ($DownloadType -eq "Page"){
                $URLContent = Get-Content ($OutfileLocation+(Split-Path $URLLine.URL -Leaf))
                $RevisedURLContent = $null
                foreach ($Line in $URLContent){
                    If ((Split-Path $URLLine.URL -Leaf) -eq 'index.html'){
                        $Line = $Line -replace '<a href="/Emu68-Imager/', '<a href="./html/'
                        $Line = $Line -replace '<a href="https://mja65.github.io/Emu68-Imager/', '<a href="./index.html'
                        $Line = $Line -replace '<img src="/Emu68-Imager/images' , '<img src="./images'
                    }
                    else{
                        $Line = $Line -replace '<a href="/Emu68-Imager/', '<a href="../html/'
                        $Line = $Line -replace '<a href="https://mja65.github.io/Emu68-Imager/', '<a href="../index.html'
                        $Line = $Line -replace '<img src="/Emu68-Imager/images' , '<img src="../images'
                    }
                    $RevisedURLContent += $Line+"`r`n"
                }
                Set-Content -Path ($OutfileLocation+(Split-Path $URLLine.URL -Leaf)+'NEW') -Value $RevisedURLContent
                $null = remove-item ($OutfileLocation+(Split-Path $URLLine.URL -Leaf))
                $null = rename-item ($OutfileLocation+(Split-Path $URLLine.URL -Leaf)+'NEW') ($OutfileLocation+(Split-Path $URLLine.URL -Leaf)) 
                If ((Split-Path $URLLine.URL -Leaf) -eq 'index.html'){
                    if (-not (Test-Path ($LocationtoDownload+'html\'))){
                        $Null = New-Item ($LocationtoDownload+'html\') -ItemType Directory   
                    }
                    $Null = Copy-Item -Path ($OutfileLocation+(Split-Path $URLLine.URL -Leaf)) -Destination ($LocationtoDownload+'html\Emu68-Imager.html')
                }

            }

        }
        else {
            Write-InformationMessage -Message "Failed to download $($URLLine.URL)!"  
            $AssetsNotDownloaded ++
        }
    
    }
    
    if ($AssetsNotDownloaded -gt 0) {
        return $false
    }
    else {
        return $true
    }
    
}
                             