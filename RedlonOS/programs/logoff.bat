@echo off
setlocal
echo Logging off...
@echo off
 powershell -c "$p='C:\RedlonOS\os_sounds\logoff.wav'; (New-Object Media.SoundPlayer $p).PlaySync();"
@echo off
:: clear startup sound flag so it plays again next login
if exist "%TEMP%\redlon_startup_played.flag" del "%TEMP%\redlon_startup_played.flag" >nul 2>&1
cls
shutdown /l
