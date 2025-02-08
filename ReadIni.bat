@echo off
 
@rem 传入本bat文件的第一个参数即为配置文件名
set CONFIG_FILE_PARAM=%1
echo config:%CONFIG_FILE_PARAM%
 
for /f "usebackq skip=1 tokens=1,2 delims==" %%a in (%CONFIG_FILE_PARAM%) do (
    @rem if %2==%%a set %3=%%b& @echo ReadConfig: %%a=%%b
    if %2==%%a set %3=%%b
)
 
@rem @echo on 
@rem goto :eof


::用法
::set config_ini_path=Setting.ini
::set config_key=name
::set config_value=默认值
::call ReadIni.bat %config_ini_path% %config_key% config_value
::echo %config_key% = %config_value%
::pause