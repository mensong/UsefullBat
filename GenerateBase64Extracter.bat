
@echo off

set InputFile=%1
set ExtractFileName=%2
set ExtracterBat=%3



::�淶·���ָ��� �� ����Ĭ�ϲ���
if "%InputFile%"=="" goto paramErr
set InputFile=%InputFile:/=\%

if "%ExtractFileName%"=="" (
	::���·���е��ļ���
	for %%I in ("%InputFile%") do set "filename=%%~nxI"
	set ExtractFileName=%filename%
)
set ExtractFileName=%ExtractFileName:/=\%

if "%ExtracterBat%"=="" (
	::���·���е��ļ���
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
echo mkdir %ExtractFileName:/=\% >>%ExtracterBat%
echo rd %ExtractFileName:/=\% >>%ExtracterBat%

::дbase64�����echo
echo certutil -decode -f src.base64 %ExtractFileName% >>%ExtracterBat%
echo del src.base64 >>%ExtracterBat%



goto done
:paramErr
echo ��������
echo Usage: GenerateBase64Extracter.bat InputFile [ExtractFileName ExtracterBat]
echo �������ExtractFileName����ExtractFileName=InputFile�����ExtracterBat�����ExtracterBat=ExtractFileName.bat

goto done
:encodeErr
echo.
echo �������certutil -encode -f %InputFile% "%tmpFile%"
echo.

:done
pause
