@echo off
title Redl0Matrix
setlocal enabledelayedexpansion

:: Set the text color to green
color 0A

:MENU
cls
echo.
echo.
echo.
echo                :::::::::  :::::::::: :::::::::  :::        ::::::::  ::::    :::
echo               :+:    :+: :+:        :+:    :+: :+:       :+:    :+: :+:+:   :+: 
echo              +:+    +:+ +:+        +:+    +:+ +:+       +:+    +:+ :+:+:+  +:+  
echo             +#++:++#:  +#++:++#   +#+    +:+ +#+       +#+    +:+ +#+ +:+ +#+   
echo            +#+    +#+ +#+        +#+    +#+ +#+       +#+    +#+ +#+  +#+#+#    
echo           #+#    #+# #+#        #+#    #+# #+#       #+#    #+# #+#   #+#+#     
echo          ###    ### ########## #########  ########## ########  ###    ####      
echo                               ___  __                                   
echo                     ^|\/^|  /\   ^|  ^|__) ^| \_/TM
echo                     ^|  ^| /~~\  ^|  ^|  \ ^| / \      V1.1
echo.
echo                                BS-DOS Console Interface
echo                               (c) 1989 - 2026 Ben Snyder
echo _____________________________________________________________________________________________
echo.
echo.

:: Only play startup sound once per user
if not exist "%TEMP%\redlon_startup_played.flag" (
    powershell -c "$p='C:\RedlonOS\os_sounds\startup.wav'; (New-Object Media.SoundPlayer $p).PlaySync();"
    echo played>"%TEMP%\redlon_startup_played.flag"
)

echo.
echo.
echo  Type "commands" for command list.
echo.
set /p choice= ***

if /i "%choice%"=="calc"     goto CALCULATOR
if /i "%choice%"=="gpt"      goto GPT
if /i "%choice%"=="dt"       goto DT
if /i "%choice%"=="pt"       goto PT
if /i "%choice%"=="ezword"   goto WORD_PROCESSOR
if /i "%choice%"=="np"       goto NOTEPAD
if /i "%choice%"=="i"        goto INTERNET
if /i "%choice%"=="r"        goto REDDIT
if /i "%choice%"=="fl"       goto FL
if /i "%choice%"=="t"        goto TIDAL
if /i "%choice%"=="tor"      goto TOR
if /i "%choice%"=="y"        goto YOUTUBE
if /i "%choice%"=="ph"       goto PH
if /i "%choice%"=="fs"       goto FILES
if /i "%choice%"=="monica"   goto M
if /i "%choice%"=="cannons"  goto CANNONS
if /i "%choice%"=="mspt"     goto PAINT
if /i "%choice%"=="music"    goto WINAMP
if /i "%choice%"=="sc"       goto SHOTCUT
if /i "%choice%"=="au"       goto AUDACITY
if /i "%choice%"=="settings" goto SETTINGS
if /i "%choice%"=="svp"      goto SVP
if /i "%choice%"=="commands" goto COMMANDS
if /i "%choice%"=="sys"      goto SYS
if /i "%choice%"=="piano"    goto PIANO
if /i "%choice%"=="seq"      goto SEQUENCER
if /i "%choice%"=="cube"     goto CUBE
if /i "%choice%"=="tunnel"   goto TUNNEL
if /i "%choice%"=="star"     goto STAR
if /i "%choice%"=="terrain"  goto TERRAIN
if /i "%choice%"=="logoff"   goto LOGOFF
if /i "%choice%"=="return"   goto RETURN
if /i "%choice%"=="sd"       exit

goto MENU

:RETURN
cls
call "C:\RedlonOS\programs\os.bat"
goto MENU

:STAR
cls
echo Launching Redl0n Starfield Warp...
powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "C:\RedlonOS\starfield.ps1"
goto MENU

:TERRAIN
cls
echo Launching Redl0n Terrain Flyover...
powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "C:\RedlonOS\programs\terrain.ps1"
goto MENU

:CALCULATOR
cls
call "C:\RedlonOS\programs\calc.bat"
goto MENU

:WORD_PROCESSOR
cls
call "C:\RedlonOS\programs\wwerd.bat"
goto MENU

:INTERNET
cls
call "C:\RedlonOS\programs\internet.bat"
goto MENU

:REDDIT
cls
call "C:\RedlonOS\programs\reddit.bat"
goto MENU

:FL
cls
call "C:\RedlonOS\programs\fl.bat"
goto MENU

:COMMANDS
cls
call "C:\RedlonOS\programs\commands.bat"
goto MENU

:TOR
cls
call "C:\RedlonOS\programs\tor.bat"
goto MENU

:TIDAL
cls
call "C:\RedlonOS\programs\tidal.bat"
goto MENU

:YOUTUBE
cls
call "C:\RedlonOS\programs\yt.bat"
goto MENU

:PH
cls
call "C:\RedlonOS\programs\ph.bat"
goto MENU

:FILES
cls
call "C:\RedlonOS\programs\files.bat"
goto MENU

:M
cls
call "C:\RedlonOS\programs\fetch.bat"
goto MENU

:CANNONS
cls
call "C:\RedlonOS\programs\cannons.bat"
goto MENU

:PAINT
cls
call "C:\RedlonOS\programs\paint.bat"
goto MENU

:SHOTCUT
cls
call "C:\RedlonOS\programs\shotcut.bat"
goto MENU

:AUDACITY
cls
call "C:\RedlonOS\programs\audacity.bat"
goto MENU

:WINAMP
cls
call "C:\RedlonOS\programs\winamp.bat"
goto MENU

:NOTEPAD
cls
call "C:\RedlonOS\programs\notepad.bat"
goto MENU

:DT
cls
call "C:\RedlonOS\programs\dtw.bat"
goto MENU

:PT
cls
call "C:\RedlonOS\programs\pt.bat"
goto MENU

:GPT
cls
call "C:\RedlonOS\programs\gpt.bat"
goto MENU

:SETTINGS
cls
call "C:\RedlonOS\programs\settings.bat"
goto MENU

:SVP
cls
call "C:\RedlonOS\programs\svp.bat"
goto MENU

:SYS
cls
call "C:\RedlonOS\programs\sys.bat"
goto MENU

:TUNNEL
cls
echo Launching Redl0n Wire Tunnel...
powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "C:\RedlonOS\programs\wiretunnel.ps1"
goto MENU

:PIANO
cls
echo Launching Redl0n Piano...
powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "C:\RedlonOS\programs\piano.ps1"
goto MENU

:SEQUENCER
cls
echo Launching Redl0n Sequencer...
powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "C:\RedlonOS\programs\sequencer.ps1"
goto MENU

:CUBE
cls
echo Launching Redl0n 3D Engine...
powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "C:\RedlonOS\programs\cube.ps1"
goto MENU

:LOGOFF
cls
call "C:\RedlonOS\programs\logoff.bat"
goto MENU