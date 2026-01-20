Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ====== MAIN FORM ======
$form               = New-Object System.Windows.Forms.Form
$form.Text          = "Redl0nOS"
$form.BackColor     = [System.Drawing.Color]::Black
$form.ForeColor     = [System.Drawing.Color]::Lime
$form.WindowState   = "Maximized"
$form.FormBorderStyle = "None"
$form.TopMost       = $true
$form.KeyPreview    = $true   # so ESC works

# ESC to quit back to Windows
$form.Add_KeyDown({
    param($sender, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Escape) {
        $form.Close()
    }
})

# ====== TITLE LABEL ======
$title              = New-Object System.Windows.Forms.Label
$title.Text         = "Redl0nOS"
$title.Font         = New-Object System.Drawing.Font("Consolas", 32, [System.Drawing.FontStyle]::Bold)
$title.AutoSize     = $true
$title.ForeColor    = [System.Drawing.Color]::Lime
$title.BackColor    = [System.Drawing.Color]::Black
$title.Location     = New-Object System.Drawing.Point(40, 30)

$form.Controls.Add($title)

# ====== SUBTITLE ======
$subtitle           = New-Object System.Windows.Forms.Label
$subtitle.Text      = "Console interface with GUI launcher"
$subtitle.Font      = New-Object System.Drawing.Font("Consolas", 12)
$subtitle.AutoSize  = $true
$subtitle.ForeColor = [System.Drawing.Color]::Lime
$subtitle.BackColor = [System.Drawing.Color]::Black
$subtitle.Location  = New-Object System.Drawing.Point(45, 80)

$form.Controls.Add($subtitle)

# ====== HELPER: create a green button ======
function New-RedlonButton {
    param(
        [string]$text,
        [int]$x,
        [int]$y,
        [scriptblock]$onClick
    )

    $btn                  = New-Object System.Windows.Forms.Button
    $btn.Text             = $text
    $btn.Font             = New-Object System.Drawing.Font("Consolas", 12)
    $btn.Size             = New-Object System.Drawing.Size(200, 40)
    $btn.Location         = New-Object System.Drawing.Point($x, $y)
    $btn.BackColor        = [System.Drawing.Color]::Black
    $btn.ForeColor        = [System.Drawing.Color]::Lime
    $btn.FlatStyle        = [System.Windows.Forms.FlatStyle]::Flat
    $btn.FlatAppearance.BorderColor = [System.Drawing.Color]::Lime
    $btn.Add_Click($onClick)
    return $btn
}

# ====== LAUNCH HELPERS ======
function Launch-Batch {
    param([string]$path)
    if (Test-Path $path) {
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$path`""
    } else {
        [System.Windows.Forms.MessageBox]::Show("File not found:`r`n$path","Error")
    }
}

function Launch-PowerShellScript {
    param([string]$path)
    if (Test-Path $path) {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -NoLogo -NoProfile -File `"$path`""
    } else {
        [System.Windows.Forms.MessageBox]::Show("File not found:`r`n$path","Error")
    }
}

# ====== BUTTONS (EDIT PATHS TO MATCH YOUR STUFF) ======
$yBase = 140
$yStep = 50
$xCol1 = 60
$xCol2 = 300
$xCol3 = 540

# Row 0
$form.Controls.Add( (New-RedlonButton "Text Mode Shell" $xCol1 $yBase {
    Launch-Batch "C:\RedlonOS\programs\os.bat"
}) )

$form.Controls.Add( (New-RedlonButton "Piano" $xCol2 $yBase {
    Launch-PowerShellScript "C:\RedlonOS\programs\piano.ps1"
}) )

$form.Controls.Add( (New-RedlonButton "Sequencer" $xCol3 $yBase {
    Launch-PowerShellScript "C:\RedlonOS\programs\sequencer.ps1"
}) )

# Row 1
$form.Controls.Add( (New-RedlonButton "FL Studio" $xCol1 ($yBase + $yStep) {
    Launch-Batch "CC:\RedlonOS\programs\fl.bat"
}) )

$form.Controls.Add( (New-RedlonButton "Internet" $xCol2 ($yBase + $yStep) {
    Launch-Batch "C:\RedlonOS\programs\internet.bat"
}) )

$form.Controls.Add( (New-RedlonButton "Reddit" $xCol3 ($yBase + $yStep) {
    Launch-Batch "C:\RedlonOS\programs\reddit.bat"
}) )

# Row 2
$form.Controls.Add( (New-RedlonButton "Notepad" $xCol1 ($yBase + 2*$yStep) {
    Launch-Batch "C:\RedlonOS\programs\notepad.bat"
}) )

$form.Controls.Add( (New-RedlonButton "Winamp" $xCol2 ($yBase + 2*$yStep) {
    Launch-Batch "C:\RedlonOS\programs\winamp.bat"
}) )

$form.Controls.Add( (New-RedlonButton "TIDAL" $xCol3 ($yBase + 2*$yStep) {
    Launch-Batch "C:\RedlonOS\programs\tidal.bat"
}) )

# Quit button
$quitBtn = New-RedlonButton "Exit to Windows (Esc)" $xCol1 ($yBase + 4*$yStep) {
    $form.Close()
}
$form.Controls.Add($quitBtn)

# ====== RUN FORM ======
[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::Run($form)