function Copy-UAEFSDB {
    param (
        $SourcePath,
        $DestinationPath
    )
    
    # $SourcePath = "C:\Users\Matt\OneDrive\Documents\DiskPartitioner\Temp\InterimAmigaDrives\System\S\_UAEFSDB.___"
    # $DestinationPath = "C:\Users\Matt\OneDrive\Documents\DiskPartitioner\Temp\InterimAmigaDrives\System\S\_UAEFSDB.___"
    $DestinationPathtoUse = "$DestinationPath\_UAEFSDB.___"

    if (Test-Path ($DestinationPathtoUse)){
        [byte[]]$BytesToAppend = [System.IO.File]::ReadAllBytes($SourcePath)
        $FileStream = New-Object -TypeName System.IO.FileStream -ArgumentList $DestinationPathtoUse, ([System.IO.FileMode]::Append)
        $FileStream.Write($BytesToAppend, 0, $BytesToAppend.Length)
        $FileStream.Dispose()
    }
    else {
        $null = Copy-Item -path $SourcePath -Destination $DestinationPath -Force -Recurse
        
    }

}