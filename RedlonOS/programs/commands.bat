@echo off
title Batch File Manager
setlocal


echo.








echo  #####                                                                    
echo #     #  ####  #    # #    #   ##   #    # #####     #      #  ####  #####
echo #       #    # ##  ## ##  ##  #  #  ##   # #    #    #      # #        #  
echo #       #    # # ## # # ## # #    # # #  # #    #    #      #  ####    #  
echo #       #    # #    # #    # ###### #  # # #    #    #      #      #   #  
echo #     # #    # #    # #    # #    # #   ## #    #    #      # #    #   #  
echo  #####   ####  #    # #    # #    # #    # #####     ###### #  ####    #  


echo _________________________________________________________________________________________
echo fs: Open File Explorer
echo dt: Display Date, time, and weather in current location
echo settings: Open Settings Menu
echo i: Open Internet
echo y: Open YouTube
echo r: Open Reddit
echo fl: Open FL Studio
echo au: Open Audacity
echo t: Open Tidal
echo music: Open WinAmp (Stored Music Library)
echo svp: Start SVP
echo pt: Open PLaylist Time Calculator
echo sc: Open ShotCut
echo mspt: Open Paint
echo np: Open NotePad
echo gpt: Open ChatGPT
echo tor: Open TOR browser
echo calc: Open Calculator
echo ezword: Open word processor
echo sys: System status
echo.
echo.

pause
if "%choice%"=="return" goto MAINMENU

:MAINMENU
cls
call "C:\Users\bs\Desktop\New folder (2)\os.bat"
goto MENU