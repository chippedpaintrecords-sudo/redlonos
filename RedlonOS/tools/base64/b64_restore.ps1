Write-Host "=== Base64 -> Original File ==="
$inputPath = Read-Host "Drag a .b64 file into this window and press Enter"

if (-not $inputPath) {
    Write-Host "No input given. Exiting."
    Read-Host "Press Enter to close"
    exit
}

# Strip quotes from drag-drop
$inputPath = $inputPath.Trim().Trim('"')

if (-not (Test-Path $inputPath)) {
    Write-Host "File not found: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

if ([IO.Path]::GetExtension($inputPath).ToLower() -ne ".b64") {
    Write-Host "Not a .b64 file: $inputPath"
    Read-Host "Press Enter to close"
    exit
}

$dir   = Split-Path $inputPath -Parent
$leaf  = Split-Path $inputPath -Leaf
$base  = [System.IO.Path]::GetFileNameWithoutExtension($leaf)

# Output the decoded file with no extension
# (You can rename it later)
$out = Join-Path $dir "$base.dec"

Write-Host "Decoding:"
Write-Host "  In : $inputPath"
Write-Host "  Out: $out"

# Read base64 text
$b64 = Get-Content $inputPath -Raw

# Clean base64 (removes noise, newlines, etc)
$b64 = $b64 -replace "[^A-Za-z0-9\+/=]", ""

try {
    $bytes = [System.Convert]::FromBase64String($b64)
}
catch {
    Write-Host "ERROR: File contains invalid base64 data."
    Read-Host "Press Enter to close"
    exit
}

# Output binary file
[System.IO.File]::WriteAllBytes($out, $bytes)

Write-Host "Done."
Write-Host "Decoded file saved as: $out"
Write-Host ""
Write-Host "Rename it to its original extension (bat, exe, zip, wav, etc)."

Read-Host "Press Enter to close"