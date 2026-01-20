Write-Host "=== WAV -> Base64 (.b64) ==="
$inputPath = Read-Host "Drag a .wav file into this window and press Enter"

if (-not $inputPath) {
    Write-Host "No input given. Exiting."
    Read-Host "Press Enter to close"
    exit
}

# Remove surrounding quotes + whitespace
$inputPath = $inputPath.Trim().Trim('"')

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

if ([IO.Path]::GetExtension($inputPath).ToLower() -ne ".wav") {
    Write-Host "Not a .wav file: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

$dir   = Split-Path $inputPath -Parent
$leaf  = Split-Path $inputPath -Leaf
$base  = [System.IO.Path]::GetFileNameWithoutExtension($leaf)
$out   = Join-Path $dir "$base.b64"

Write-Host "Encoding:"
Write-Host "  In : $inputPath"
Write-Host "  Out: $out"

$bytes  = [System.IO.File]::ReadAllBytes($inputPath)
$base64 = [Convert]::ToBase64String($bytes)

Set-Content -Encoding ascii -Path $out -Value $base64

Write-Host "Done."
Read-Host "Press Enter to close"