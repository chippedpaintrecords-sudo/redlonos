param(
    [string]$InputFile,
    [string]$OutputWav = "output.wav"
)

# Settings
$sampleRate = 44100
$bit0Freq = 1000
$bit1Freq = 2000
$samplesPerBit = 200   # ~20ms per bit, nice & cassette-friendly

# Read input file
$bytes = [System.IO.File]::ReadAllBytes($InputFile)

# Convert bytes to bitstream
$bits = foreach ($b in $bytes) {
    for ($i = 7; $i -ge 0; $i--) {
        ($b -shr $i) -band 1
    }
}

# Build audio data
$wav = New-Object System.Collections.Generic.List[byte]

function Write-Wav-Header($dataLength) {
    $totalLen = $dataLength + 36

    $header = New-Object byte[] 44
    [System.Text.Encoding]::ASCII.GetBytes("RIFF").CopyTo($header, 0)
    [BitConverter]::GetBytes($totalLen).CopyTo($header, 4)
    [System.Text.Encoding]::ASCII.GetBytes("WAVEfmt ").CopyTo($header, 8)
    [BitConverter]::GetBytes(16).CopyTo($header, 16)       # fmt chunk size
    [BitConverter]::GetBytes(1).CopyTo($header, 20)        # PCM
    [BitConverter]::GetBytes(1).CopyTo($header, 22)        # Mono
    [BitConverter]::GetBytes($sampleRate).CopyTo($header, 24)
    [BitConverter]::GetBytes($sampleRate).CopyTo($header, 28) # byte rate
    [BitConverter]::GetBytes(1).CopyTo($header, 32)         # block align
    [BitConverter]::GetBytes(8).CopyTo($header, 34)         # bits per sample
    [System.Text.Encoding]::ASCII.GetBytes("data").CopyTo($header, 36)
    [BitConverter]::GetBytes($dataLength).CopyTo($header, 40)

    return $header
}

# Generate wave data
foreach ($bit in $bits) {
    $freq = if ($bit -eq 0) { $bit0Freq } else { $bit1Freq }

    for ($i = 0; $i -lt $samplesPerBit; $i++) {
        $t = 2 * [math]::PI * $freq * ($i / $sampleRate)
        $sample = [byte](([math]::Sin($t) * 127) + 128)
        $wav.Add($sample)
    }
}

# Write WAV file
$header = Write-Wav-Header $wav.Count
[System.IO.File]::WriteAllBytes($OutputWav, $header + $wav.ToArray())

Write-Host "WAV written to $OutputWav"