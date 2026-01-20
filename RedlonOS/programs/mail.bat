@echo off
setlocal enabledelayedexpansion

:: Set up email server settings
set SMTP_SERVER=smtp.gmail.com
set SMTP_PORT=587
set SENDER_EMAIL=youremail@gmail.com
set SENDER_PASS=yourpassword

:: Ask for recipient email
cls


echo EEEEEEE       MM    MM   AAA   IIIII LL      TM  
echo EE      zzzzz MMM  MMM  AAAAA   III  LL      
echo EEEEE     zz  MM MM MM AA   AA  III  LL      
echo EE       zz   MM    MM AAAAAAA  III  LL      
echo EEEEEEE zzzzz MM    MM AA   AA IIIII LLLLLLL 
echo _______________________________________________
echo Copyright 1989 Zenith Software INC                                             
echo ***********************************************
echo ***********************************************
echo Enter recipient email address:
set /p RECIPIENT_EMAIL=

:: Ask for email subject
echo Enter the subject of the email:
set /p SUBJECT=

:: Ask for email body
echo Enter your message:
set /p BODY=

:: Path to Blat executable
set BLAT_PATH=C:\blat\blat.exe

:: Send email using Blat
"%BLAT_PATH%" -to "%RECIPIENT_EMAIL%" -subject "%SUBJECT%" -body "%BODY%" -server "%SMTP_SERVER%" -port "%SMTP_PORT%" -f "%SENDER_EMAIL%" -auth login -u "%SENDER_EMAIL%" -pw "%SENDER_PASS%" -tls

:: Display success message
if %errorlevel% equ 0 (
    echo Email sent successfully!
) else (
    echo Failed to send email.
)

pause
