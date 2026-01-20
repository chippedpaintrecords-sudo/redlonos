
mode con: cols=160 lines=50

@echo off
title Redl0n Matrix Boot
setlocal EnableDelayedExpansion
color 0A

:BOOT
cls
echo Redl0n Matrix Firmware v1.07
echo (c) 1989-2026 Redlon Systems / Zenith Labs
echo ----------------------------------------------------
echo.
call :line [ OK ] Power-on self test
call :line [ OK ] Detecting devices
call :line [ OK ] Initializing memory map

echo.
echo.
echo Boot sequence complete.
echo.
goto MAINMENU


:MAINMENU
cls
echo Launching Redl0nOS...
call "C:\RedlonOS\programs\os.bat"
goto BOOT


:: --------- helpers ---------

:line
echo %*
timeout /t 1 >nul
exit /b

:progressAnim
echo Initializing Redl0nOS core...
for /L %%P in (0,10,100) do (
    call :progress %%P
)
exit /b

:progress
set "p=%1"
setlocal EnableDelayedExpansion
set /a filled=p/4
set "bar="

for /L %%I in (1,1,25) do (
    if %%I LEQ !filled! (
        set "bar=!bar!#"
    ) else (
        set "bar=!bar!."
    )
)

echo [!bar!] !p!%%
timeout /t 1 >nul
endlocal
exit /b