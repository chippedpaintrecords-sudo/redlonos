# Redl0nOS Triple-Track Sequencer with True Polyphony (slower, but smooth)
# Tracks A, B, C run simultaneously
# Pattern format per track: a---a---g---g---
# '-' = rest, Ctrl+C to stop

$ErrorActionPreference = 'Continue'

# Map note keys to wav file paths
$notePaths = @{

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

'n' = 'C:\RedlonOS\piano\kick.wav'
'm' = 'C:\RedlonOS\piano\hat.wav'
',' = 'C:\RedlonOS\piano\snare.wav'

'z' = 'C:\RedlonOS\piano\lc.wav'
'x' = 'C:\RedlonOS\piano\ld.wav'
'c' = 'C:\RedlonOS\piano\le.wav'
'v' = 'C:\RedlonOS\piano\lf.wav'
'b' = 'C:\RedlonOS\piano\lg.wav'
'.' = 'C:\RedlonOS\piano\la.wav'

'1' = 'C:\RedlonOS\piano\lcs.wav'
'2' = 'C:\RedlonOS\piano\lds.wav'
'3' = 'C:\RedlonOS\piano\lfs.wav'
'4' = 'C:\RedlonOS\piano\lgs.wav'

}

function Play-Note {
    param([char]$ch)

    $key = $ch.ToString().ToLower()
    if (-not $notePaths.ContainsKey($key)) { return }

    $path = $notePaths[$key]
    if (-not (Test-Path $path)) { return }

    # Separate hidden PowerShell process so notes fully overlap
    Start-Process powershell -WindowStyle Hidden -ArgumentList @(
        '-NoLogo',
        '-NoProfile',
        '-Command',
        "[System.Media.SoundPlayer]::new('$path').PlaySync()"
    ) | Out-Null
}

Clear-Host
Write-Host "=========== Redl0n Triple-Track Sequencer (Slow Poly) ===========
Valid keys: a s d f g h j k (w/e/r/t/y = sharps)
Pattern format per track: a---a---g---g---
'-' = rest
Ctrl+C to stop looping
==================================================================="
Write-Host ""

# Track A
$patternA = Read-Host "Track A pattern"
if ([string]::IsNullOrWhiteSpace($patternA)) { Write-Host "Empty pattern. Exiting."; exit }
$stepsA = $patternA.ToCharArray()

# Track B
$patternB = Read-Host "Track B pattern"
if ([string]::IsNullOrWhiteSpace($patternB)) { Write-Host "Empty pattern. Exiting."; exit }
$stepsB = $patternB.ToCharArray()

# Track C
$patternC = Read-Host "Track C pattern"
if ([string]::IsNullOrWhiteSpace($patternC)) { Write-Host "Empty pattern. Exiting."; exit }
$stepsC = $patternC.ToCharArray()

# BPM
$bpmInput = Read-Host "Enter BPM (e.g. 120)"
[int]$bpm = 0
if (-not [int]::TryParse($bpmInput, [ref]$bpm)) { $bpm = 120 }
if ($bpm -lt 20) { $bpm = 20 }
if ($bpm -gt 300) { $bpm = 300 }

$stepMs = [int](60000 / $bpm)

Clear-Host
Write-Host "=========== Redl0n Triple-Track Sequencer (Slow Poly) ===========
Track A : $patternA
Track B : $patternB
Track C : $patternC
BPM     : $bpm
Looping... Ctrl+C to stop
==================================================================="
Write-Host ""

$lenA = $stepsA.Length
$lenB = $stepsB.Length
$lenC = $stepsC.Length
$i = 0

while ($true) {

    $chA = $stepsA[$i % $lenA].ToString().ToLower()
    $chB = $stepsB[$i % $lenB].ToString().ToLower()
    $chC = $stepsC[$i % $lenC].ToString().ToLower()

    if ($chA -ne '-') { Play-Note $chA }
    if ($chB -ne '-') { Play-Note $chB }
    if ($chC -ne '-') { Play-Note $chC }

    Write-Host ("A:{0}  B:{1}  C:{2}  Step:{3}" -f $chA, $chB, $chC, $i) -NoNewline
    Start-Sleep -Milliseconds $stepMs
    Write-Host "`r" -NoNewline

    $i++
}