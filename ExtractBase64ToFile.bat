@echo off

::��bat�ļ���base64�ַ����ͷŵ��ļ���
::Usage: ExtractBase64ToFile.bat Base64String OutputFile
::��ʹ�� certutil -encode SourceFile Base64File ��Ŀ���ļ���ת��Ϊbase64�ַ���

set base64str=%1
set outputFile=%2
set tmpFile="%temp%\_base64.tmp"

echo %base64str%>%tmpFile%
certutil -decode -f %tmpFile% %outputFile%
del %tmpFile%