@echo off
color 0A
:: Display Current Date and Time
echo Current Date and Time:
echo =======================
date /t
time /t
echo.

:: Display Weather (using wttr.in API)
echo Current Weather:
echo ================
curl wttr.in?format=3
echo.

pause
goto :RETURN

:RETURN
cls
call "C:\Users\bs\Desktop\New folder (2)\os.bat"