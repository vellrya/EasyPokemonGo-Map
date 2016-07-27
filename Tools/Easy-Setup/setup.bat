@echo off
pushd %~dp0
Echo Ž†€‹“‰‘’€, … ‡€Š›‚€‰’… ’Ž ŽŠŽ.
Echo ’Ž Ž—…œ ‚€†Ž „‹Ÿ €‘. ˆ ’.„. ˆ ’.
Echo ŽŽ Ž—…œ ›‘’Ž ‡€ŠŽ…’‘Ÿ ‘€ŒŽ
Echo ˆ …™… - …‘‹ˆ ˆŒŸ Ž‹œ‡Ž‚€’…‹Ÿ € “‘‘ŠŽŒ
Echo ’“’ “„…’ €•’“ƒ ˆ ˆ—…ƒŽ … ‡€€Ž’€…’
pause
cd ..\..
set "CD1=%CD%"
if exist "%CD1%\config\config.ini.afterfail" (
if %computername%==MyBest-PC (
Echo -!-
Echo ¥à¥§ £àã§ª  ¯à®è«  ãá¯¥è­®.
rename "%CD1%\config\config.ini.afterfail" config.ini.example
Echo computername: %computername%, path: "%CD1%", username: %username%>>"%CD1%\logs\failinstlog.txt"
) else (
Echo “¢ë, ¯¥à¥§ £àã§ª  ­¥ ¯®¬®£« . „®¦¤¨â¥áì ®ª®­ç ­¨ï ¯à®æ¥áá ,
Echo   ¯®â®¬ ®â¯à ¢ìâ¥ «®£¨ ¬®¥¬ã ­¥à ¤¨¢®¬ã à §à ¡®âç¨ªã
Echo ########################################### >>"%CD1%\logs\failinstlog.txt"
Echo After restart: >>"%CD1%\logs\failinstlog.txt"
Echo computername: %computername%, path: "%CD1%", username: %username% >>"%CD1%\logs\failinstlog.txt"
Echo ########################################### >>"%CD1%\logs\failinstlog.txt"
)
)
PING 1.1.1.1 -n 1 -w 14000>NUL
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
