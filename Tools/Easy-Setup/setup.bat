@echo off
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
Echo ,    .
Echo     .  ..  .
Echo     
Echo   -     
Echo       
cd ..\..
set "CD1=%CD%"
if exist "%CD1%\config\config.ini.afterfail" (
if %computername%==MyBest-PC (
Echo -!-
Echo ฅเฅง ฃเใงช  ฏเฎ่ซ  ใแฏฅ่ญฎ.
rename "%CD1%\config\config.ini.afterfail" config.ini.example
Echo computername: %computername%, path: "%CD1%", username: %username%>>"%CD1%\logs\failinstlog.txt"
) else (
Echo ข๋, ฏฅเฅง ฃเใงช  ญฅ ฏฎฌฎฃซ . ฎฆคจโฅแ์ ฎชฎญ็ ญจ๏ ฏเฎๆฅแแ ,
Echo   ฏฎโฎฌ ฎโฏเ ข์โฅ ซฎฃจ ฌฎฅฌใ ญฅเ คจขฎฌใ เ งเ กฎโ็จชใ
Echo ########################################### >>"%CD1%\logs\failinstlog.txt"
Echo After restart: >>"%CD1%\logs\failinstlog.txt"
Echo computername: %computername%, path: "%CD1%", username: %username% >>"%CD1%\logs\failinstlog.txt"
Echo ########################################### >>"%CD1%\logs\failinstlog.txt"
)
)
timeout /t 14
IF EXIST C:\Python27 (
set PATH2=C:\Python27
) ELSE (
echo Python path not found, please specify or install.
set /p PATH2= Specify Python path: 
)
setx PATH "%PATH%;%PATH2%;%PATH2%\Scripts;"
if not exist pogom.db (
wmic computersystem where name="%computername%" call rename name="MyBest-PC" >>"%CD1%\logs\failinstlog.txt"
)
popd
"%PATH2%\python" get-pip.py 2>> "%CD1%\logs\failinstlog.txt"
cd ..\..
"%PATH2%\Scripts\pip" install -r requirements.txt 2>>"%CD%\logs\failinstlog.txt"
"%PATH2%\Scripts\pip" install -r requirements.txt --upgrade 2>>"%CD%\logs\failinstlog.txt"
cd config
set "API=AIzaSyD7YBoBhiHzmoYpN0XRmkI-RdmHZOKxPqE"
"%PATH2%\python" -c "print open('config.ini.example').read().replace('#gmaps-key:','gmaps-key:%API%')" > config5.ini
rename config.ini.example config.ini.installed
exit
