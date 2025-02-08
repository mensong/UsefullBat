
@echo off

set InputFile=%1
set ExtractFileName=%2
set ExtracterBat=%3



::规范路径分隔符
if "%InputFile%"=="" goto paramErr
set InputFile=%InputFile:/=\%

if "%ExtractFileName%"=="" goto paramErr
set ExtractFileName=%ExtractFileName:/=\%

if "%ExtracterBat%"=="" goto paramErr
set ExtracterBat=%ExtracterBat:/=\%

echo.
echo InputFile=%InputFile%
echo ExtractFileName=%ExtractFileName%
echo ExtracterBat=%ExtracterBat%
mkdir %ExtracterBat% >nul 2>nul
rd %ExtracterBat% >nul 2>nul
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
echo mkdir %ExtractFileName% ^>nul 2^>nul >>%ExtracterBat%
echo rd %ExtractFileName% ^>nul 2^>nul >>%ExtracterBat%

::写base64解码的echo
echo certutil -decode -f src.base64 %ExtractFileName% >>%ExtracterBat%
echo del src.base64 >>%ExtracterBat%



goto done
:paramErr
echo 参数错误：
echo 用法: GenerateBase64Extracter.bat InputFile ExtractFileName ExtracterBat
echo 举例：GenerateBase64Extracter.bat D:\1.jpg data\1.jpg D:\1.jpg.bat 
echo       把D:\1.jpg打包成D:\1.jpg.bat，当D:\1.jpg.bat执行时会生成data\1.jpg
pause

goto done
:encodeErr
echo.
echo 编码错误：certutil -encode -f %InputFile% "%tmpFile%"
echo.
pause

:done
