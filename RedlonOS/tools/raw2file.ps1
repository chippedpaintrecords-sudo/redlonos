Write-Host "=== RAW -> DEC (binary copy) ==="
$inputPath = Read-Host "Drag your .raw file into this window and press Enter"

if (-not $inputPath) {
    Write-Host "No input given. Exiting."
    Read-Host "Press Enter to close"
    exit
}

$inputPath = $inputPath.Trim().Trim('"')

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

if ([IO.Path]::GetExtension($inputPath).ToLower() -ne ".raw") {
    Write-Host "Not a .raw file: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

$dir   = Split-Path $inputPath -Parent
$leaf  = Split-Path $inputPath -Leaf
$base  = [System.IO.Path]::GetFileNameWithoutExtension($leaf)
$out   = Join-Path $dir ($base + ".dec")

Write-Host "Converting:"
Write-Host "  IN : $inputPath"
Write-Host "  OUT: $out"

$bytes = [System.IO.File]::ReadAllBytes($inputPath)
[System.IO.File]::WriteAllBytes($out, $bytes)

Write-Host "Done. Rename .dec to whatever the original extension was."
Read-Host "Press Enter to close"