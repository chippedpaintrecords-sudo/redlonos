@echo off
title Simple Batch Word Processor
setlocal enabledelayedexpansion

:: Create the directory for saving text files (if it doesn't exist)
if not exist "C:\WordProcessorFiles" mkdir "C:\WordProcessorFiles"

:: Menu to choose option
:MENU
cls
echo ==============================
echo     Simple Batch Word Processor
echo ==============================
echo.
echo 1. Create a New Text File
echo 2. Open an Existing Text File
echo 3. Exit
echo.
set /p choice=Choose an option (1, 2, or 3): 

if "%choice%"=="1" goto CREATE
if "%choice%"=="2" goto OPEN
if "%choice%"=="3" exit

goto MENU

:: Create a New Text File
:CREATE
cls
echo Enter the name for the new text file (without extension):
set /p filename=
set filepath=C:\WordProcessorFiles\%filename%.txt

echo You can start typing below. Press Ctrl+Z to save and exit.
echo -----------------------------------------
echo.
copy con "%filepath%"
echo File saved as %filename%.txt.
pause
goto MENU

:: Open an Existing Text File
:OPEN
cls
echo Enter the name of the text file to open (without extension):
set /p filename=
set filepath=C:\WordProcessorFiles\%filename%.txt

if exist "%filepath%" (
    echo Opening "%filename%.txt"...
    notepad "%filepath%"
) else (
    echo File does not exist. Please try again.
)
pause
goto MENU
