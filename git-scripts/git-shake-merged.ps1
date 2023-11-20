git branch --merged | ForEach-Object {
    $branchName = $_.Trim()  # Trim any leading/trailing whitespaces
    if ($branchName -notin @('develop', 'master') -and $branchName -notlike '* master') {
        git branch $branchName -d
        Write-Host "Deleted branch: $branchName"
    }
}

Write-Host "Deleted All Merged Branches"
