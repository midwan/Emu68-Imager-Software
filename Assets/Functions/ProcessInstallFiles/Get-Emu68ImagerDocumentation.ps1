function Get-Emu68ImagerDocumentation {
    param (
        $LocationtoDownload
    )

   # $LocationtoDownload ='E:\PiStorm\Docs\'

   $DownloadURLs = Get-InputCSVs -DocumentationURLs

    foreach ($URLLine in $DownloadURLs){
        
        $Extension = [System.IO.Path]::GetExtension("$(Split-Path $URLLine.URL -Leaf)")

        If ((Split-Path $URLLine.URL -Leaf) -eq 'index.html'){
            $OutfileLocation = $LocationtoDownload 
        }
        elseif ($Extension -eq '.png'){
            $OutfileLocation = $LocationtoDownload+'images\'
        }
        else {
            $OutfileLocation = ($LocationtoDownload+'html\')
        }
        if (-not (test-path $OutfileLocation)){
                $null = New-Item $OutfileLocation -ItemType Directory
        }
        
        if ((Get-DownloadFile -DownloadURL $URLLine.URL -OutputLocation ($OutfileLocation+(Split-Path $URLLine.URL -Leaf)) -NumberofAttempts 3) -eq $true){
            if (($OutfileLocation+(Split-Path $URLLine.URL -Leaf)).IndexOf('.html') -gt 0){
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
        else{
            return $false
        }

    }
    return $true
}