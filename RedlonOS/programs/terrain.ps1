# RedlonMatrix Terrain Flyover
# Hit ENTER to return to the main RedlonMatrix screen.

$rawui = $Host.UI.RawUI
$rawui.CursorSize = 1

# Match window size so it doesn't get cut off
$width  = $rawui.WindowSize.Width
$height = $rawui.WindowSize.Height - 2   # small margin

$depth  = 24      # how many "distance slices"

$t = 0.0          # time / forward movement

while ($true) {

    # Allow exit via ENTER
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.Key -eq "Enter") { break }
    }

    # Clear buffer to spaces
    $buffer = [char[]]::new($width * $height)
    for ($i = 0; $i -lt $buffer.Length; $i++) { $buffer[$i] = ' ' }

    # Draw terrain from far (small) to near (big)
    for ($z = 2; $z -le $depth; $z++) {

        # perspective factor: farther slices move less, are higher on screen
        $persp = ($depth - $z + 1) / $depth

        for ($x = 0; $x -lt $width; $x++) {

            # world X: squish more as it gets farther away
            $worldX = ($x - $width / 2) * $persp * 0.25 + $t

            # "height" using stacked sines as fake noise
            $h1 = [math]::Sin($worldX * 0.7) * 4
            $h2 = [math]::Sin($worldX * 0.23 + $t * 0.2) * 6
            $heightVal = $h1 + $h2

            # base row on screen where this distance slice sits (horizon-ish)
            $baseY = [int](($height - 5) - ($depth - $z) * 1.3)

            # final terrain height on screen: higher mountains = lower on screen
            $y = $baseY - [int]$heightVal

            if ($y -ge 0 -and $y -lt $height) {
                $idx = $x + $y * $width
                $buffer[$idx] = '#'

                # fill below with ground dots if still empty
                for ($yy = $y + 1; $yy -lt $height; $yy++) {
                    $idx2 = $x + $yy * $width
                    if ($buffer[$idx2] -eq ' ') {
                        $buffer[$idx2] = '.'
                    }
                }
            }
        }
    }

    # move "forward"
    $t += 0.25

    # render frame
    $rawui.CursorPosition = @{ X = 0; Y = 0 }
    $sb = New-Object System.Text.StringBuilder

    for ($y = 0; $y -lt $height; $y++) {
        for ($x = 0; $x -lt $width; $x++) {
            [void]$sb.Append($buffer[$x + $y * $width])
        }
        [void]$sb.Append("`n")
    }

    Write-Host $sb.ToString()
    Start-Sleep -Milliseconds 40
}