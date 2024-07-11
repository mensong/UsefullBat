
@echo off

set InputFile=%1
set ExtractFileName=%2
set ExtracterBat=%3



::规范路径分隔符 及 处理默认参数
if "%InputFile%"=="" goto paramErr
set InputFile=%InputFile:/=\%

if "%ExtractFileName%"=="" (
	::获得路径中的文件名
	for %%I in ("%InputFile%") do set "filename=%%~nxI"
	set ExtractFileName=%filename%
)
set ExtractFileName=%ExtractFileName:/=\%

if "%ExtracterBat%"=="" (
	::获得路径中的文件名
	for %%I in ("%ExtractFileName%") do set "filename=%%~nxI"
	set ExtracterBat=Generated\%filename%.bat
	mkdir Generated >nul 2>nul
)
set ExtracterBat=%ExtracterBat:/=\%

echo.
echo InputFile=%InputFile%
echo ExtractFileName=%ExtractFileName%
echo ExtracterBat=%ExtracterBat%
echo.



::原文件转base64临时文件
set tmpFile=%temp%\_base64.tmp
certutil -encode -f %InputFile% "%tmpFile%"
if not %errorlevel%==0 goto encodeErr



::创建ExtracterBat
::写ExtracterBat必须的echo
echo @echo off >%ExtracterBat%
echo del src.base64 ^>nul 2^>nul >>%ExtracterBat%

::写base64所有行的echo
for /f "tokens=*" %%a in (%tmpFile%) do (
	echo echo %%a ^>^>src.base64 >>%ExtracterBat%
)

::确保ExtractFileName的父目录存在
echo mkdir %ExtractFileName:/=\% >>%ExtracterBat%
echo rd %ExtractFileName:/=\% >>%ExtracterBat%

::写base64解码的echo
echo certutil -decode -f src.base64 %ExtractFileName% >>%ExtracterBat%
echo del src.base64 >>%ExtracterBat%



goto done
:paramErr
echo 参数错误
echo Usage: GenerateBase64Extracter.bat InputFile [ExtractFileName ExtracterBat]
echo 如果不填ExtractFileName，则ExtractFileName=InputFile；如果ExtracterBat不填，则ExtracterBat=ExtractFileName.bat

goto done
:encodeErr
echo.
echo 编码错误：certutil -encode -f %InputFile% "%tmpFile%"
echo.

:done
pause
