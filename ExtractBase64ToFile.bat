@echo off

::把bat文件中base64字符串释放到文件中
::Usage: ExtractBase64ToFile.bat Base64String OutputFile
::可使用 certutil -encode SourceFile Base64File 把目标文件先转换为base64字符串

set base64str=%1
set outputFile=%2
set tmpFile="%temp%\_base64.tmp"

echo %base64str%>%tmpFile%
certutil -decode -f %tmpFile% %outputFile%
del %tmpFile%