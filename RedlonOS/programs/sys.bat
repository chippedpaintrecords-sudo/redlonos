@echo off
title Redl0n System Monitor
setlocal EnableDelayedExpansion

:MENU
cls
color 0A
set "barLen=30"

echo =================== SYSTEM STATS ====================
echo.

:: ==========================================
:: CPU LOAD
:: ==========================================
set "cpuLoad="
for /f "skip=1" %%A in ('wmic cpu get loadpercentage') do (
    if not "%%A"=="" (
        set "cpuLoad=%%A"
        goto :gotCpu
    )
)
:gotCpu

if not defined cpuLoad set "cpuLoad=0"

:: ==========================================
:: RAM USAGE
:: ==========================================
for /f "tokens=2 delims==" %%A in ('wmic OS get TotalVisibleMemorySize /Value') do set "totalMem=%%A"
for /f "tokens=2 delims==" %%A in ('wmic OS get FreePhysicalMemory /Value') do set "freeMem=%%A"

set /a usedMem=totalMem-freeMem
set /a ramPct=usedMem*100/totalMem

:: ==========================================
:: DISK USAGE (C:)
:: ==========================================
for /f "tokens=2 delims==" %%A in ('wmic logicaldisk where "DeviceID='C:'" get Size /Value') do set "diskSize=%%A"
for /f "tokens=2 delims==" %%A in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /Value') do set "diskFree=%%A"

set /a diskSizeMB=diskSize/1048576
set /a diskFreeMB=diskFree/1048576
set /a diskUsedMB=diskSizeMB-diskFreeMB
set /a diskPct=diskUsedMB*100/diskSizeMB

:: ==========================================
:: NETWORK STATS (IP + ping)
:: ==========================================
set "ipAddr=Unknown"
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set "ipAddr=%%A"
    set "ipAddr=!ipAddr: =!"
    goto :gotIP
)
:gotIP

set "pingAvg=Unknown"
for /f "tokens=4 delims==," %%A in ('ping -n 4 8.8.8.8 ^| find "Average"') do (
    set "pingAvgRaw=%%A"
)
if defined pingAvgRaw (
    set "pingAvgRaw=%pingAvgRaw: =%"
    set "pingAvg=%pingAvgRaw:ms=%"
)

:: ==========================================
:: BUILD BARS
:: ==========================================
call :MakeBar %cpuLoad% cpuBar
call :MakeBar %ramPct%  ramBar
call :MakeBar %diskPct% diskBar

:: ==========================================
:: SYSTEM HEALTH
:: ==========================================
set "health=GOOD"
set "healthMsg=System operating within normal ranges."

if %cpuLoad% GEQ 90 (
    set "health=WARNING"
    set "healthMsg=High CPU usage detected."
)

if %ramPct% GEQ 90 (
    set "health=WARNING"
    set "healthMsg=High memory usage detected."
)

if %diskPct% GEQ 95 (
    set "health=WARNING"
    set "healthMsg=Very low free space on C: drive."
)

if not "%pingAvg%"=="Unknown" (
    if %pingAvg% GEQ 200 (
        set "health=WARNING"
        set "healthMsg=High network latency detected."
    )
)

:: ==========================================
:: RANDOM SYSTEM FORTUNE
:: ==========================================
set "f0=All systems nominal. Engage vibes."
set "f1=Now would be a good time to rip a bong."
set "f2=Reminder - Drink some fucking water..."
set "f3=Fuck bitches -  Get money."
set "f4=Today is a good day to record a cassette."
set "f5=Trust your ears more than your meters."
set "f6=Good things are coming your way..."
set "f7=Fuck bitches - Get money"

set /a idx=%random% %%6
for /f "tokens=1,* delims==" %%A in ('set f%idx%') do set "fortune=%%B"

:: ==========================================
:: OUTPUT
:: ==========================================
echo CPU Load   : %cpuLoad%%%   !cpuBar!
echo RAM Usage  : %ramPct%%%    !ramBar!
echo Disk C:    : %diskPct%%%   !diskBar!
echo.
echo Network IP : %ipAddr%
echo Ping Avg   : %pingAvg% ms
echo.
echo System Health: %health%
echo Status      : %healthMsg%
echo.
echo Fortune     : %fortune%
echo ================================================
echo.
pause
goto :RETURN

:RETURN
cls
call "C:\Users\bs\Desktop\New folder (2)\os.bat"


:: ===== FUNCTION: MakeBar %percent% varName =====
:MakeBar
set "percent=%~1"
if "%percent%"=="" set "percent=0"
if %percent% GTR 100 set "percent=100"

set /a filled=percent*barLen/100

set "bar=["
for /L %%I in (1,1,%barLen%) do (
    if %%I LEQ !filled! (
        set "bar=!bar!#"
    ) else (
        set "bar=!bar!."
    )
)
set "bar=!bar!]"
set "%~2=!bar!"
goto :eof