@echo off
echo Сделал youtube.com/okplaygame
set PATH2=C:\Python27
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
pushd %~dp0
if exist "%~dp0config\config.ini.example" (
goto label
) else (
goto label1
)

:label
setx PATH "%PATH%;%PATH2%;%PATH2%\Scripts;"

if exist "%PATH2%\Lib\site-packages\*.*" (
rd "%PATH2%\Lib\site-packages\" /s /q
)
cd Tools\Easy-Setup
"%PATH2%\python" get-pip.py
cd ..\..
xcopy /H /Y /C /R /S /Q "%~dp0site-packages\*.*" C:\Python27\Lib\site-packages\


cd config
set "API=AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE"
"%PATH2%\python" -c "print open('config.ini.example').read().replace('#gmaps-key:','gmaps-key:%API%')" > config5.ini
set /p type= Введите одно слово - через что вы хотите авторизоваться (ptc или google): 

if "%type%" NEQ "ptc" (
if "%type%" NEQ "google" (
echo Only google or ptc can be used. Authoriazation type set to ptc default
set "type=ptc"
)
)
"%PATH2%\python" -c "print open('config5.ini').read().replace('#auth-service:','auth-service:%type%')" > config4.ini
set /p login= Введите ваш логин: 
"%PATH2%\python" -c "print open('config4.ini').read().replace('#username:','username:%login%')" > config3.ini
 
set /p pswd= Введите ваш пароль: 
"%PATH2%\python" -c "print open('config3.ini').read().replace('#password:','password:%pswd%')" > config2.ini
del config5.ini
del config4.ini
del config3.ini
del config.ini.example
popd
:label1
cd %~dp0
set /p coords= Введите координаты (Например - Moscow) (Нажмите Enter, чтобы использовать ваши предыдущие координаты (если есть!)): 
if exist "pogom.db" ( 
  if "%coords%"=="" (
  GOTO label3
  )
) else (
if "%coords%"=="" (
  echo Увы, предыдущие координаты не найдены. Введи заново.
  GOTO label1
) 
)
cd config
if not exist config2.ini (
rename config.ini config2.ini
)
"%PATH2%\python" -c "print open('config2.ini').read().replace('#location:','location:%coords%')" > config.ini
del config2.ini
cd %~dp0
:label3
Echo Если у вас проблемы с установкой новых координат
Echo очистите кеш браузера и запустите startme.bat еще раз.
cd %~dp0
start "c:\program files\internet explorer\iexplore" "http://localhost:5000"
"%PATH2%\python" runserver.py -k AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE -t 4 -L ru
exit
