#Creates Markdown text for a list of images in the file system
$allPhotos = Get-Item photos/*.jpg | Sort-Object BaseName

Write-Host "## Photos"
# Write Markdown image syntax
$prevFirstWord = ''
$allPhotos | ForEach-Object {
    $imgName = $_.BaseName
    $firstWord = ($imgName -split ' ')[0]
    if (-not ($firstWord -eq $prevFirstWord)) {
        $prevFirstWord = $firstWord
        Write-Host "### $firstWord"
    }
    Write-Host "![$imgName][$imgName]"
}

Write-Host "`n`n"
# Write Markdown path references
$allPhotos | ForEach-Object {
    $imgPath = (Resolve-Path -Path $_ -relative) -replace "\\", "/"
    $imgName = $_.BaseName
    Write-Host "[$imgName]:`t$imgPath `"$imgName`""
}
