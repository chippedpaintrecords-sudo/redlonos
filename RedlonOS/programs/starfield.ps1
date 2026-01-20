# RedlonMatrix Starfield Warp
# Hit ENTER to return to the main RedlonMatrix screen.

$width = 80
$height = 40

$starCount = 200
$depth = 40.0
$speed = 0.6
$fov = 40.0

$rawui = $Host.UI.RawUI
$rawui.CursorSize = 1

# Initialize stars
$stars = @()
for ($i = 0; $i -lt $starCount; $i++) {
    $stars += [pscustomobject]@{
        x = (Get-Random -Minimum -1.0 -Maximum 1.0)
        y = (Get-Random -Minimum -1.0 -Maximum 1.0)
        z = (Get-Random -Minimum 1.0 -Maximum $depth)
    }
}

function Reset-Star {
    param([ref]$star)

    $star.Value.x = (Get-Random -Minimum -1.0 -Maximum 1.0)
    $star.Value.y = (Get-Random -Minimum -1.0 -Maximum 1.0)
    $star.Value.z = $depth
}

function Project {
    param([double]$x, [double]$y, [double]$z)

    if ($z -le 0.1) { return $null }

    $sx = [int]($width  / 2 + ($x / $z) * $fov)
    $sy = [int]($height / 2 + ($y / $z) * $fov)

    if ($sx -lt 0 -or $sx -ge $width -or $sy -lt 0 -or $sy -ge $height) {
        return $null
    }

    return [pscustomobject]@{ x = $sx; y = $sy }
}

while ($true) {

    # Allow exit via ENTER
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.Key -eq "Enter") { break }
    }

    # Prepare buffer
    $buffer = New-Object char[] ($width * $height)
    for ($i = 0; $i -lt $buffer.Length; $i++) {
        $buffer[$i] = ' '
    }

    # Update and draw stars
    for ($i = 0; $i -lt $stars.Count; $i++) {
        $star = $stars[$i]

        # Move star toward camera
        $star.z -= $speed
        if ($star.z -le 0.2) {
            Reset-Star ([ref]$stars[$i])
            $star = $stars[$i]
        }

        $p = Project $star.x $star.y $star.z
        if ($p -eq $null) { continue }

        # Depth-based brightness
        $brightness = $star.z / $depth
        if     ($brightness -lt 0.2) { $ch = '#' }
        elseif ($brightness -lt 0.4) { $ch = '*' }
        elseif ($brightness -lt 0.7) { $ch = '+' }
        else                         { $ch = '.' }

        $idx = $p.x + $p.y * $width
        $buffer[$idx] = $ch
    }

    # Render frame
    $rawui.CursorPosition = @{ X = 0; Y = 0 }
    $sb = New-Object System.Text.StringBuilder

    for ($y = 0; $y -lt $height; $y++) {
        for ($x = 0; $x -lt $width; $x++) {
            [void]$sb.Append($buffer[$x + $y * $width])
        }
        [void]$sb.Append("`n")
    }

    Write-Host $sb.ToString()
    Start-Sleep -Milliseconds 30
}