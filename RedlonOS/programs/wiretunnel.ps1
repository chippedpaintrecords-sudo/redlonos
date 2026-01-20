# RedlonMatrix Wire Tunnel Animation (fixed)
# Hit ENTER to return to the main RedlonMatrix screen.

$width = 80
$height = 40

# Projection depth & speed
$depth = 30.0
$speed = 0.30

# Tunnel rings
$ringCount = 40

# Create ring depth positions (behind the camera, moving forward)
$zPositions = @(for ($i = 0; $i -lt $ringCount; $i++) { -1.0 * $i })

$rawui = $Host.UI.RawUI
$rawui.CursorSize = 1

function Project {
    param([double]$x, [double]$y, [double]$z)

    $fov = 80.0
    $z2 = $z + $depth

    # If it's too close or behind the camera, skip it
    if ($z2 -lt 1.0) {
        return $null
    }

    $sx = [int]($width / 2  + ($x / $z2) * $fov)
    $sy = [int]($height / 2 + ($y / $z2) * $fov)

    return [pscustomobject]@{ x = $sx; y = $sy }
}

while ($true) {

    # Allow exit via ENTER
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.Key -eq "Enter") { break }
    }

    # Prepare draw buffer
    $buffer = New-Object char[] ($width * $height)
    for ($i = 0; $i -lt $buffer.Length; $i++) { $buffer[$i] = ' ' }

    foreach ($z in $zPositions) {

        # If it's too close, don't even try to draw this ring
        if ($z + $depth -lt 1.0) {
            continue
        }

        # Wire circle resolution
        for ($i = 0; $i -lt 32; $i++) {
            $angle = $i * [math]::PI * 2 / 32
            $x = [math]::Cos($angle) * 8
            $y = [math]::Sin($angle) * 4

            $p = Project $x $y $z
            if ($p -eq $null) { continue }

            if ($p.x -ge 0 -and $p.x -lt $width -and $p.y -ge 0 -and $p.y -lt $height) {
                $idx = $p.x + $p.y * $width
                $buffer[$idx] = '#'
            }
        }
    }

    # Move rings forward
    for ($i = 0; $i -lt $zPositions.Count; $i++) {
        $zPositions[$i] += $speed
        if ($zPositions[$i] -gt 1.0) {
            $zPositions[$i] = -$ringCount
        }
    }

    # Render final frame
    $rawui.CursorPosition = @{ X = 0; Y = 0 }
    $sb = New-Object System.Text.StringBuilder

    for ($y = 0; $y -lt $height; $y++) {
        for ($x = 0; $x -lt $width; $x++) {
            [void]$sb.Append($buffer[$x + $y * $width])
        }
        [void]$sb.Append("`n")
    }

    Write-Host $sb.ToString()
    Start-Sleep -Milliseconds 20
}