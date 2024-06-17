param (
    [string]$textToReplace,
    [string]$replacement
)
$textToReplaceEscaped = [regex]::Escape($textToReplace)

Get-ChildItem -Recurse | Where-Object { $_.Extension -match '\.(js|jsx)$' } | ForEach-Object {
    $filePath = $_.FullName
    $content = Get-Content $filePath
    foreach ($line in $content) {
        $originalLine = $line
        $modifiedLine = $line -replace $textToReplaceEscaped, "$replacement"
        if ($originalLine -cne $modifiedLine) {
            $replacementsCount = $replacementsCount + 1
            Write-Host "Original: " $originalLine.trim() -ForegroundColor Red
            Write-Host "Modified: " $modifiedLine.trim() -ForegroundColor Green
            Write-Host "No Match"
        }
    }
    (Get-Content $_.FullName) -replace $textToReplaceEscaped, "$replacement" | Set-Content $_.FullName
}
