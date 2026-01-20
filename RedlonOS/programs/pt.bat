



@echo off
setlocal enabledelayedexpansion

color 0e

:: Initialize total time variables
set /a total_minutes=0
set /a total_seconds=0

:: Loop to input song lengths
:input_loop
cls
echo " ______   __         ______     __  __     ______   __     __    __     ______    ";
echo "/\  == \ /\ \       /\  __ \   /\ \_\ \   /\__  _\ /\ \   /\ "-./  \   /\  ___\   ";
echo "\ \  _-/ \ \ \____  \ \  __ \  \ \____ \  \/_/\ \/ \ \ \  \ \ \-./\ \  \ \  __\   ";
echo " \ \_\    \ \_____\  \ \_\ \_\  \/\_____\    \ \_\  \ \_\  \ \_\ \ \_\  \ \_____\ ";
echo "  \/_/     \/_____/   \/_/\/_/   \/_____/     \/_/   \/_/   \/_/  \/_/   \/_____/ ";
echo "           Playlist length calculator                                             ";
echo "               (c) 2024 Ben Snyder                                                ";
echo =====================================================================================
echo Enter song length (mm:ss format) (Enter "x" to exit)
echo =====================================================================================
echo Current total length: !total_minutes! minutes and !total_seconds! seconds
echo.

:: Prompt for song length
set /p song_length=Enter song length (mm:ss):

:: Check if input is empty to end the loop
if "%song_length%"=="" goto end

:: Extract minutes and seconds from the input
for /f "tokens=1,2 delims=:" %%a in ("%song_length%") do (
    set /a minutes=%%a
    set /a seconds=%%b
)

:: Add to total time
set /a total_minutes+=minutes
set /a total_seconds+=seconds

:: If total seconds are 60 or more, convert to minutes
if !total_seconds! geq 60 (
    set /a total_minutes+=total_seconds / 60
    set /a total_seconds=!total_seconds! %% 60
)

:end
pause
if "%choice%"=="x" goto RETURN
goto :RETURN

:RETURN
cls
call "C:\Users\bs\Desktop\New folder (2)\os.bat"
