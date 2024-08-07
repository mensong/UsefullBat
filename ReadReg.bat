@echo off

::第一个参数为返回值变量名（不带%）
set RETURN_NAME=%1
if "%RETURN_NAME%"=="" (
	set RETURN_NAME=REG_VALUE
)
::第二个参数为注册表路径
if "%REG_PATH%"=="" (
	set REG_PATH=%2
)
::第三个参数为键名
if "%REG_KEY%"=="" (
	set REG_KEY=%3
)

echo return_name=%RETURN_NAME%
echo reg_path=%REG_PATH%
echo reg_key=%REG_KEY%

set %RETURN_NAME%=
if "%REG_PATH%"=="" (
	goto err
)
if "%REG_KEY%"=="" (
	goto err
)

for /f "tokens=2*" %%a in ('reg query "%REG_PATH%" /v "%REG_KEY%"') do set "READ_VALUE=%%b"
set %RETURN_NAME%=%READ_VALUE%
::echo The value of "%REG_KEY%" is "%RETURN_NAME%"

goto done
:err
echo 错误，用法参考：
echo 1.
echo set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
echo set REG_KEY=Path
echo call ReadReg.bat
echo echo %%REG_VALUE%%
echo.
echo 2.
echo set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
echo set REG_KEY=Path
echo call ReadReg.bat return_Val
echo echo %%return_Val%%
echo.
echo 3.
echo call ReadReg.bat RETURN_VALUE HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment Path
echo echo %%RETURN_VALUE%%
echo.
echo 如果路径有空格，则需要使用1或2

:done
