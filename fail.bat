@echo off
mode con:cols=85 lines=10
color 4f
echo ���, ᥩ�� �� �࠭� �� �����:
echo "���� localhost �� �������� ��⠭����� ᮥ�������."
echo ��-� ��諮 �� ⠪. ���⥬� ����஥�� ⠪�� ��ࠧ��, �⮡� ���� ���� �஡����.
Echo -----------------------------------------------------------------------------------
Echo ��ࠢ�� ����� logs � ��:
Echo vk.me/vellrya
Echo username: %username%>> "%~dp0logs\failinstlog.txt"
Echo compname: %computername%>> "%~dp0logs\failinstlog.txt"
Echo path: "%CD%">> "%~dp0logs\failinstlog.txt"
TIMEOUT /T 15
exit