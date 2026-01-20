Write-Host "=== WAV -> Original Binary (header-stripped) ==="
$inputPath = Read-Host "Drag your encoded .wav file into this window and press Enter"

if (-not $inputPath) {
    Write-Host "No input given. Exiting."
    Read-Host "Press Enter to close"
    exit
}

# Clean drag-drop quotes & spaces
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
$out   = Join-Path $dir "$base.dec"

Write-Host "Decoding:"
Write-Host "  In : $inputPath"
Write-Host "  Out: $out"

$wavBytes = [System.IO.File]::ReadAllBytes($inputPath)

if ($wavBytes.Length -le 44) {
    Write-Host "File too small to be valid PCM WAV (<=44 bytes)."
    Read-Host "Press Enter to close"
    exit
}

# Strip standard 44-byte header, keep payload as-is
$payload = $wavBytes[44..($wavBytes.Length - 1)]
[System.IO.File]::WriteAllBytes($out, $payload)

Write-Host "Done."
Write-Host "Decoded file saved as: $out"
Write-Host "Rename it to the original extension (e.g. .zip, .exe, .bat, etc)."
Read-Host "Press Enter to close"