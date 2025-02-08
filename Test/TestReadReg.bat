
set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
set REG_KEY=Path
call ..\ReadReg.bat a
echo %a%

pause