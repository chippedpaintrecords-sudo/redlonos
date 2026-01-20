Write-Host "=== WAV -> RAW (8-bit PCM payload) ==="
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
$out   = Join-Path $dir "$base.raw"

Write-Host "Converting:"
Write-Host "  In : $inputPath"
Write-Host "  Out: $out"

$wavBytes = [System.IO.File]::ReadAllBytes($inputPath)

if ($wavBytes.Length -le 44) {
    Write-Host "File is too small to be a valid PCM WAV (<=44 bytes)."
    Read-Host "Press Enter to close"
    exit
}

# Strip standard 44-byte header
$rawBytes = $wavBytes[44..($wavBytes.Length - 1)]
[System.IO.File]::WriteAllBytes($out, $rawBytes)

Write-Host "Done."
Read-Host "Press Enter to close"