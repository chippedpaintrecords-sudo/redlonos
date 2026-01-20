# Simple console piano for Redl0nOS
# Keys: A S D F G H J K
# Quit: Q

$ErrorActionPreference = 'Stop'

# Map keys to wav files
$noteMap = @{
    'a' = 'C:\RedlonOS\piano\c.wav'
    's' = 'C:\RedlonOS\piano\d.wav'
    'd' = 'C:\RedlonOS\piano\e.wav'
    'f' = 'C:\RedlonOS\piano\f.wav'
    'g' = 'C:\RedlonOS\piano\g.wav'
    'h' = 'C:\RedlonOS\piano\a.wav'
    'j' = 'C:\RedlonOS\piano\b.wav'
    'k' = 'C:\RedlonOS\piano\c2.wav'

    'w' = 'C:\RedlonOS\piano\csharp.wav'
    'e' = 'C:\RedlonOS\piano\dsharp.wav'
    'r' = 'C:\RedlonOS\piano\fsharp.wav'
    't' = 'C:\RedlonOS\piano\gsharp.wav'
    'y' = 'C:\RedlonOS\piano\asharp.wav'
    'u' = 'C:\RedlonOS\piano\nsharp.wav'
    'i' = 'C:\RedlonOS\piano\dssharp.wav'
}

# Preload players so they respond quickly
$players = @{}
foreach ($entry in $noteMap.GetEnumerator()) {
    $key  = $entry.Key
    $path = $entry.Value

    if (Test-Path $path) {
        $player = [System.Media.SoundPlayer]::new($path)
        $player.Load()
        $players[$key] = $player
    } else {
        Write-Host "Missing file for key '$key': $path"
    }
}

[Console]::TreatControlCAsInput = $true

Clear-Host
Write-Host "================ Redl0n Piano ================"
Write-Host "Keys: A S D F G H J K"
Write-Host "Keys (sharps/flats): W E R T Y U I"
Write-Host "Quit: x"
Write-Host "==============================================="
Write-Host ""

while ($true) {
    # Read a single keypress, no echo
    $keyInfo = [System.Console]::ReadKey($true)
    $ch = $keyInfo.KeyChar.ToString().ToLower()

    if ($ch -eq 'x') {
        break
    }

    if ($players.ContainsKey($ch)) {
        $players[$ch].Play()
    }
}