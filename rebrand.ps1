$targetFolder = "c:\Users\zahra\Desktop\discord freelance\clinics\hospital-management-emr"

# Exclude list
$excludeDirs = @(".git", ".github", "node_modules", "bin", "obj", ".vs", "packages", "backup")

# File extensions to include
$includeExts = @("*.cs", "*.json", "*.ts", "*.html", "*.md", "*.js", "*.css", "*.csproj", "*.sln", "*.config", "*.txt", "*.yml")

Write-Host "Finding files to process..."
$files = Get-ChildItem -Path $targetFolder -Recurse -Include $includeExts | Where-Object {
    $path = $_.FullName
    $skip = $false
    foreach ($dir in $excludeDirs) {
        if ($path -match "\\$dir\\") {
            $skip = $true
            break
        }
    }
    return -not $skip
}

Write-Host "Found $($files.Count) files. Starting text replacement..."

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw
        if ($null -ne $content) {
            $original = $content
            
            # Replace email
            $content = $content -replace "shiv_koirala@yahoo\.com", "fromza.dev@gmail.com"
            
            # Replace Danphe EMR
            $content = $content -replace "Danphe EMR", "Fromza EMR"
            $content = $content -replace "DanpheEMR", "FromzaEMR"
            $content = $content -replace "DanpheApp", "FromzaApp"
            
            # Case sensitive replacements
            $content = $content -creplace "Danphe", "Fromza"
            $content = $content -creplace "DANPHE", "FROMZA"
            $content = $content -creplace "danphe", "fromza"

            if ($original -cne $content) {
                Write-Host "Updating file: $($file.FullName)"
                Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            }
        }
    } catch {
        Write-Host "Failed to process file: $($file.FullName) - $_"
    }
}

Write-Host "Text replacement complete."

# Rename files containing 'Danphe'
Write-Host "Finding files to rename..."
$filesToRename = Get-ChildItem -Path $targetFolder -Recurse | Where-Object {
    $_.Name -match "Danphe" -and $_.PSIsContainer -eq $false
} | Where-Object {
    $path = $_.FullName
    $skip = $false
    foreach ($dir in $excludeDirs) {
        if ($path -match "\\$dir\\") {
            $skip = $true
            break
        }
    }
    return -not $skip
}

foreach ($file in $filesToRename) {
    try {
        $newName = $file.Name -replace "Danphe", "Fromza"
        Write-Host "Renaming file $($file.Name) to $newName"
        Rename-Item -Path $file.FullName -NewName $newName
    } catch {
        Write-Host "Failed to rename file: $($file.FullName) - $_"
    }
}

# Rename directories containing 'Danphe'
# Since renaming a parent dir changes paths of children, we sort descending by depth
Write-Host "Finding directories to rename..."
$dirsToRename = Get-ChildItem -Path $targetFolder -Recurse | Where-Object {
    $_.Name -match "Danphe" -and $_.PSIsContainer -eq $true
} | Where-Object {
    $path = $_.FullName
    $skip = $false
    foreach ($dir in $excludeDirs) {
        if ($path -match "\\$dir\\") {
            $skip = $true
            break
        }
    }
    return -not $skip
} | Sort-Object -Property @{Expression={$_.FullName.Length}; Descending=$true}

foreach ($dir in $dirsToRename) {
    try {
        $newName = $dir.Name -replace "Danphe", "Fromza"
        Write-Host "Renaming directory $($dir.Name) to $newName"
        Rename-Item -Path $dir.FullName -NewName $newName
    } catch {
        Write-Host "Failed to rename directory: $($dir.FullName) - $_"
    }
}

Write-Host "Rebranding complete!"
