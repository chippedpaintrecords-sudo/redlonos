
Write-Host "=== FILE → RAW (bit-perfect dump) ==="
$inputPath = Read-Host "Drag your file into this window and press Enter"

if (-not $inputPath) {
    Write-Host "No input given. Exiting."
    Read-Host "Press Enter to close"
    exit
}

# Clean drag/drop quotes & whitespace
$inputPath = $inputPath.Trim().Trim('"')

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

$dir  = Split-Path $inputPath -Parent
$name = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)
$outPath = Join-Path $dir ($name + ".raw")

Write-Host "Converting:"
Write-Host "  IN : $inputPath"
Write-Host "  OUT: $outPath"

# Read every byte exactly and dump it straight to .raw
$bytes = [System.IO.File]::ReadAllBytes($inputPath)
[System.IO.File]::WriteAllBytes($outPath, $bytes)
