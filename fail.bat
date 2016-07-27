@echo off
mode con:cols=85 lines=10
color 4f
echo Увы, сейчас на экране вы видите:
echo "Сайт localhost не позволяет установить соединение."
echo Что-то пошло не так. Система настроена таким образом, чтобы решить вашу проблему.
Echo -----------------------------------------------------------------------------------
Echo Отправьте папку logs в вк:
Echo vk.me/vellrya
Echo username: %username%>> "%~dp0logs\failinstlog.txt"
Echo compname: %computername%>> "%~dp0logs\failinstlog.txt"
Echo path: "%CD%">> "%~dp0logs\failinstlog.txt"
TIMEOUT /T 15
exit