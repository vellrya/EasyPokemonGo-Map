@echo off
pushd %~dp0
Echo ����������, �� ���������� ��� ����.
Echo ��� ����� ����� ��� ���. � �.�. � �.�
Echo ��� ����� ������ ��������� ����
cd ..\..
set "CD1=%CD%"
if exist = "%CD1%\config\config.ini.afterfail" (
if %computername%==MyBest-PC (
Echo -!-
Echo ��१���㧪� ��諠 �ᯥ譮.
rename "%CD1%\config\config.ini.afterfail" config.ini.example
Echo computername: %computername%, path: %CD1%, username: %username% >> "%CD1%\logs\failinstlog.txt"
) else (
Echo ���, ��१���㧪� �� �������. �������� ����砭�� �����,
Echo � ��⮬ ��ࠢ�� ���� ����� ��ࠤ����� ࠧࠡ��稪�
Echo ########################################### >> "%CD1%\logs\failinstlog.txt"
Echo After restart: >> "%CD1%\logs\failinstlog.txt"
Echo computername: %computername%, path: %CD1%, username: %username% >> "%CD1%\logs\failinstlog.txt"
Echo ########################################### >> "%CD1%\logs\failinstlog.txt"
)
)
timeout /t 13
IF EXIST C:\Python27 (
set PATH2=C:\Python27
) ELSE (
echo Python path not found, please specify or install.
set /p PATH2= Specify Python path: 
)
setx PATH "%PATH%;%PATH2%;%PATH2%\Scripts;"
popd
if not exist pogom.db (
wmic computersystem where name="%computername%" rename "MyBest-PC"
)
"%PATH2%\python" get-pip.py 2>> "%CD1%\logs\failinstlog.txt"
cd ..\..
"%PATH2%\Scripts\pip" install -r requirements.txt 2>>"%CD%\logs\failinstlog.txt"
"%PATH2%\Scripts\pip" install -r requirements.txt --upgrade 2>>"%CD%\logs\failinstlog.txt"
cd config
set "API=AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE"
"%PATH2%\python" -c "print open('config.ini.example').read().replace('#gmaps-key:','gmaps-key:%API%')" > config5.ini
rename config.ini.example config.ini.installed
exit
