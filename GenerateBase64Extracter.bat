
@echo off

set InputFile=%1
set ExtractFileName=%2
set ExtracterBat=%3



::�淶·���ָ���
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



::ԭ�ļ�תbase64��ʱ�ļ�
set tmpFile=%temp%\_base64.tmp
certutil -encode -f %InputFile% "%tmpFile%"
if not %errorlevel%==0 goto encodeErr



::����ExtracterBat
::дExtracterBat�����echo
echo @echo off >%ExtracterBat%
echo del src.base64 ^>nul 2^>nul >>%ExtracterBat%

::дbase64�����е�echo
for /f "tokens=*" %%a in (%tmpFile%) do (
	echo echo %%a ^>^>src.base64 >>%ExtracterBat%
)

::ȷ��ExtractFileName�ĸ�Ŀ¼����
echo mkdir %ExtractFileName% ^>nul 2^>nul >>%ExtracterBat%
echo rd %ExtractFileName% ^>nul 2^>nul >>%ExtracterBat%

::дbase64�����echo
echo certutil -decode -f src.base64 %ExtractFileName% >>%ExtracterBat%
echo del src.base64 >>%ExtracterBat%



goto done
:paramErr
echo ��������
echo �÷�: GenerateBase64Extracter.bat InputFile ExtractFileName ExtracterBat
echo ������GenerateBase64Extracter.bat D:\1.jpg data\1.jpg D:\1.jpg.bat 
echo       ��D:\1.jpg�����D:\1.jpg.bat����D:\1.jpg.batִ��ʱ������data\1.jpg
pause

goto done
:encodeErr
echo.
echo �������certutil -encode -f %InputFile% "%tmpFile%"
echo.
pause

:done
