@echo off
cls
color 0A

echo 192.168.88.5 1
echo 10.100.215.86 2

set KEY=0
set /p KEY=[12]
if %KEY% == 1 goto IP1
if %KEY% == 2 goto IP2
:IP1BACK
:IP2BACK
goto SETIP
goto eof

goto eof
:IP1
set IP=192.168.88.5
set MASK=255.255.255.0
set GATEWAY=192.168.88.1
set NAME="本地连接"
set DNS1="114.114.114.114"
set DNS2="8.8.8.8"
goto IP1BACK

goto eof
:IP2
set IP=10.100.215.86
set MASK=255.255.255.0
set GATEWAY=10.100.215.1
set NAME="本地连接"
set DNS1="114.114.114.114"
set DNS2="8.8.8.8"
goto IP2BACK

:SETIP
netsh interface ip set address %NAME% static %IP% %MASK% %GATEWAY%
netsh interface ip add dns "本地连接" %DNS1% index=1 > nul
netsh interface ip add dns "本地连接" %DNS2% index=2 > nul
goto eof
echo !		netsh interface ip set address %NAME% static %IP% %MASK% %GATEWAY%
echo !		netsh interface ip set address name="本地连接" source=dhcp
echo !		netsh interface ip set dns name="本地连接" source=dhcp
echo !		netsh interface ip add dns "本地连接" %DNS1% index=1 > nul
echo !		netsh interface ip add dns "本地连接" %DNS2% index=2 > nul
:eof
