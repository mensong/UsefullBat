@echo off
 
@rem ���뱾bat�ļ��ĵ�һ��������Ϊ�����ļ���
set CONFIG_FILE_PARAM=%1
echo config:%CONFIG_FILE_PARAM%
 
for /f "usebackq skip=1 tokens=1,2 delims==" %%a in (%CONFIG_FILE_PARAM%) do (
    @rem if %2==%%a set %3=%%b& @echo ReadConfig: %%a=%%b
    if %2==%%a set %3=%%b
)
 
@rem @echo on 
@rem goto :eof


::�÷�
::set config_ini_path=Setting.ini
::set config_key=name
::set config_value=Ĭ��ֵ
::call ReadIni.bat %config_ini_path% %config_key% config_value
::echo %config_key% = %config_value%
::pause