# Spinning ASCII Cube in PowerShell (RedlonMatrix edition)
# Ctrl + C to stop

$width = 60
$height = 30

# 1D char buffer for the screen
$buffer = New-Object char[] ($width * $height)

# Cube vertices as objects (way safer than weird nested arrays)
$points = @(
    [pscustomobject]@{ x = -1.0; y = -1.0; z = -1.0 }
    [pscustomobject]@{ x =  1.0; y = -1.0; z = -1.0 }
    [pscustomobject]@{ x =  1.0; y =  1.0; z = -1.0 }
    [pscustomobject]@{ x = -1.0; y =  1.0; z = -1.0 }
    [pscustomobject]@{ x = -1.0; y = -1.0; z =  1.0 }
    [pscustomobject]@{ x =  1.0; y = -1.0; z =  1.0 }
    [pscustomobject]@{ x =  1.0; y =  1.0; z =  1.0 }
    [pscustomobject]@{ x = -1.0; y =  1.0; z =  1.0 }
)

# Edges: pairs of vertex indices
$edges = @(
    @(0,1), @(1,2), @(2,3), @(3,0),
    @(4,5), @(5,6), @(6,7), @(7,4),
    @(0,4), @(1,5), @(2,6), @(3,7)
)

# Rotation angles
$angA = 0.0
$angB = 0.0
$angC = 0.0

function Rotate {
    param(
        [double]$x,
        [double]$y,
        [double]$z,
        [double]$a,
        [double]$b,
        [double]$c
    )

    $sinA = [math]::Sin($a); $cosA = [math]::Cos($a)
    $sinB = [math]::Sin($b); $cosB = [math]::Cos($b)
    $sinC = [math]::Sin($c); $cosC = [math]::Cos($c)

    # Rotate around Y (B)
    $x1 = $x * $cosB + $z * $sinB
    $z1 = -$x * $sinB + $z * $cosB

    # Rotate around X (A)
    $y1 = $y * $cosA - $z1 * $sinA
    $z2 = $y * $sinA + $z1 * $cosA

    # Rotate around Z (C)
    $x2 = $x1 * $cosC - $y1 * $sinC
    $y2 = $x1 * $sinC + $y1 * $cosC

    return [pscustomobject]@{ x = $x2; y = $y2; z = $z2 }
}

function Project {
    param(
        [double]$x,
        [double]$y,
        [double]$z
    )

    $dist = 5.0
    $scale = 18.0
    $z2 = $z + $dist
    if ($z2 -eq 0) { $z2 = 0.0001 } # avoid divide by zero

    $sx = [int]($width / 2 + $x * $scale / $z2)
    $sy = [int]($height / 2 + $y * $scale / $z2)

    return [pscustomobject]@{ x = $sx; y = $sy }
}

# Move cursor instead of clearing screen fully every frame
$rawui = $Host.UI.RawUI

while ($true) {

    # If Enter is pressed, exit the cube and return to caller
    if ([console]::KeyAvailable) {
        $key = [console]::ReadKey($true)
        if ($key.Key -eq "Enter") {
            break
        }
    }

    # Clear buffer
    for ($i = 0; $i -lt $buffer.Length; $i++) {
        $buffer[$i] = ' '
    }

    # For each edge, rotate vertices, project, then draw line
    foreach ($edge in $edges) {
        $i1 = $edge[0]
        $i2 = $edge[1]

        $p1 = $points[$i1]
        $p2 = $points[$i2]

        $r1 = Rotate -x $p1.x -y $p1.y -z $p1.z -a $angA -b $angB -c $angC
        $r2 = Rotate -x $p2.x -y $p2.y -z $p2.z -a $angA -b $angB -c $angC

        $s1 = Project -x $r1.x -y $r1.y -z $r1.z
        $s2 = Project -x $r2.x -y $r2.y -z $r2.z

        $x1 = $s1.x; $y1 = $s1.y
        $x2 = $s2.x; $y2 = $s2.y

        # Bresenham line
        $dx = [math]::Abs($x2 - $x1)
        $dy = [math]::Abs($y2 - $y1)
        $sx = $(if ($x1 -lt $x2) { 1 } else { -1 })
        $sy = $(if ($y1 -lt $y2) { 1 } else { -1 })
        $err = $dx - $dy

        while ($true) {
            if ($x1 -ge 0 -and $x1 -lt $width -and $y1 -ge 0 -and $y1 -lt $height) {
                $idx = $x1 + $y1 * $width
                $buffer[$idx] = '#'
            }
            if ($x1 -eq $x2 -and $y1 -eq $y2) { break }
            $e2 = 2 * $err
            if ($e2 -gt -$dy) { $err -= $dy; $x1 += $sx }
            if ($e2 -lt $dx) { $err += $dx; $y1 += $sy }
        }
    }

    # Draw frame
    $rawui.CursorPosition = @{ X = 0; Y = 0 }
    $sb = New-Object System.Text.StringBuilder
    for ($y = 0; $y -lt $height; $y++) {
        for ($x = 0; $x -lt $width; $x++) {
            [void]$sb.Append($buffer[$x + $y * $width])
        }
        [void]$sb.Append("`n")
    }
    Write-Host $sb.ToString()

    # Spin cube
    $angA += 0.04
    $angB += 0.03
    $angC += 0.02

    Start-Sleep -Milliseconds 30
}