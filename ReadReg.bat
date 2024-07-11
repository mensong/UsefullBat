@echo off

:::::::::::::::::::::::::::::::::::::::::::
::输入1	set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
::输入2	set REG_KEY=Path
::调用	call ReadReg.bat
::输出	%REG_VALUE%

::或

:: call ReadReg.bat RETURN_VALUE HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment Path
:: echo %REG_VALUE%
:::::::::::::::::::::::::::::::::::::::::::

::第一个参数为返回值变量名（不带%）
set RETURN_NAME=%1
::第二个参数为注册表路径
if "%REG_PATH%"=="" (
	set REG_PATH=%2
)
::第三个参数为键名
if "%REG_KEY%"=="" (
	set REG_KEY=%3
)

if "%RETURN_NAME%"=="" (
	set RETURN_NAME=REG_VALUE
)
if "%REG_PATH%"=="" (
	goto err
)
if "%REG_KEY%"=="" (
	goto err
)

set REG_VALUE=
for /f "tokens=2*" %%a in ('reg query "%REG_PATH%" /v "%REG_KEY%"') do set "READ_VALUE=%%b"
set %RETURN_NAME%=%READ_VALUE%
::echo The value of "%REG_KEY%" is "%REG_VALUE%"

goto done
:err
echo set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
echo set REG_KEY=Path
echo call ReadReg.bat
echo echo %%REG_VALUE%%
echo 或
echo set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
echo set REG_KEY=Path
echo call ReadReg.bat return_Val
echo echo %%return_Val%%
echo 或
echo call ReadReg.bat RETURN_VALUE HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment Path
echo echo %%RETURN_VALUE%%

:done
