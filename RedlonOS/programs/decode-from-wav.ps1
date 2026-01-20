param(
    [string]$InputWav,
    [string]$OutputFile = "restored.bin"
)

$sampleRate = 44100
$bit0Freq = 1000
$bit1Freq = 2000
$samplesPerBit = 200

# Read wav
$data = [System.IO.File]::ReadAllBytes($InputWav)
$data = $data[44..($data.Length-1)]  # skip header

# Decode bits
$bits = New-Object System.Collections.Generic.List[int]

for ($i = 0; $i -lt $data.Length; $i += $samplesPerBit) {
    $chunk = $data[$i..[math]::Min($i + $samplesPerBit - 1, $data.Length-1)]
    
    # crude but effective frequency detection (sum of zero crossings)
    $zeroCross = 0
    for ($j = 1; $j -lt $chunk.Count; $j++) {
        if (($chunk[$j] - 128) * ($chunk[$j-1] - 128) -lt 0) {
            $zeroCross++
        }
    }

    # Threshold to decide 1kHz vs 2kHz
    $bits.Add( if ($zeroCross -lt 15) { 0 } else { 1 } )
}

# Convert bits → bytes
$out = New-Object System.Collections.Generic.List[byte]

for ($i = 0; $i -lt $bits.Count; $i += 8) {
    if ($i + 7 -ge $bits.Count) { break }
    $val = 0
    for ($b = 0; $b -lt 8; $b++) {
        $val = ($val -shl 1) -bor $bits[$i + $b]
    }
    $out.Add([byte]$val)
}

[System.IO.File]::WriteAllBytes($OutputFile, $out.ToArray())
Write-Host "Restored file written to $OutputFile"