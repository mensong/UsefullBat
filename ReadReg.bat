@echo off

:::::::::::::::::::::::::::::::::::::::::::
::����1	set REG_PATH=HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment
::����2	set REG_KEY=Path
::����	call ReadReg.bat
::���	%REG_VALUE%

::��

:: call ReadReg.bat RETURN_VALUE HKEY_LOCAL_MACHINE\SOFTWARE\DefaultUserEnvironment Path
:: echo %REG_VALUE%
:::::::::::::::::::::::::::::::::::::::::::

::��һ������Ϊ����ֵ������������%��
set RETURN_NAME=%1
::�ڶ�������Ϊע���·��
if "%REG_PATH%"=="" (
	set REG_PATH=%2
)
::����������Ϊ����
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
echo ���·���пո�����Ҫʹ��1��2

:done
set REG_PATH=
set REG_KEY=
set RETURN_NAME=
set REG_VALUE=