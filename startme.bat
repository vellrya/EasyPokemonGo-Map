@echo off
echo ������ youtube.com/okplaygame
IF EXIST C:\Python27 (
set PATH2=C:\Python27
) ELSE (
echo ��⮭ �� ��⠭����� � ��७� ��᪠ �. ����� ���� ��� �����⠭���.
set /p PATH2= Specify Python path: 
)
pushd %~dp0
if exist = "%~dp0config\config.ini.example" goto label
:label
cd Tools\Easy-Setup
"%PATH2%\python" get-pip.py
cd ..\..
XCopy "%~dp0site-packages\*.*" "%PATH2%\Lib\site-packages\*.*" /H /E /G /Q /R /Y
cd config
set "API=AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE"
"%PATH2%\python" -c "print open('config.ini.example').read().replace('#gmaps-key:','gmaps-key:%API%')" > config5.ini
set /p type= ������ ���� ᫮�� - �१ �� �� ��� ���ਧ������� (ptc ��� google): 

if "%type%" NEQ "ptc" (
if "%type%" NEQ "google" (
echo Only google or ptc can be used. Authoriazation type set to ptc default
set "type=ptc"
)
)
"%PATH2%\python" -c "print open('config5.ini').read().replace('#auth-service:','auth-service:%type%')" > config4.ini
set /p login= ������ ��� �����: 
"%PATH2%\python" -c "print open('config4.ini').read().replace('#username:','username:%login%')" > config3.ini
 
set /p pswd= ������ ��� ��஫�: 
"%PATH2%\python" -c "print open('config3.ini').read().replace('#password:','password:%pswd%')" > config2.ini
del config5.ini
del config4.ini
del config3.ini
popd
:label1
cd %~dp0
set /p coords= ������ ���न���� (���ਬ�� - Moscow) (������ Enter, �⮡� �ᯮ�짮���� ��� �।��騥 ���न���� (�᫨ ����!)): 
if exist "pogom.db" ( 
  if "%coords%"=="" (
  GOTO label3
  )
) else (
if "%coords%"=="" (
  echo ���, �।��騥 ���न���� �� �������. ����� ������.
  GOTO label1
) 
)
cd config
if not exist config2.ini (
rename config.ini config2.ini
)
"%PATH2%\python" -c "print open('config2.ini').read().replace('#location:','location:%coords%')" > config.ini
del config2.ini
:label3
Echo �᫨ � ��� �஡���� � ��⠭����� ����� ���न���
Echo ����� ��� ��㧥� � ������� startme.bat �� ࠧ.
cd %~dp0
start "c:\program files\internet explorer\iexplore" "http://localhost:5000"
"%PATH2%\python" runserver.py -k AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE -t 2 -L ru & cd config & del config.ini.example || "%PATH2%\python" runserver.py -k AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE -t 2 -L ru >> "%~dp0logs\failinstlog.txt" & Echo ���, ��-� ��諮 �� ⠪. & start fail.bat & timeout /t 10
exit
