Add-Type @"
using System;
using System.Runtime.InteropServices;

public class WinTools {
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@

# Get handle to the current console window
$hwnd = [WinTools]::GetConsoleWindow()

# 3 = SW_MAXIMIZE
[WinTools]::ShowWindow($hwnd, 3)