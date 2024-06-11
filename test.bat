@echo off
setlocal enabledelayedexpansion
title Internet service 
color 0D
chcp 65001 >nul

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (goto gotPrivileges) else (goto getPrivileges)

:getPrivileges
if '%1'=='ELEV' (shift & goto gotPrivileges)
setlocal DisableDelayedExpansion
set "batchPath=%~f0"
setlocal EnableDelayedExpansion
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:gotPrivileges
setlocal & pushd .

:menu
cls
echo.
echo  ______  _____   _____   __        
echo /\__  _\/\  __`\/\  __`\/\ \       
echo \/_/\ \/\ \ \/\ \ \ \/\ \ \ \      
echo    \ \ \ \ \ \ \ \ \ \ \ \ \ \  __ 
echo     \ \ \ \ \ \_\ \ \ \_\ \ \ \L\ \
echo      \ \_\ \ \_____\ \_____\ \____/
echo       \/_/  \/_____/\/_____/\/___/ 
echo                                   
echo                                   
echo.
echo Gợi ý: Gõ "help" để hiện thị danh sách các lệnh
echo.
set /p "command=[user] > "

:execute
if /i "%command%"=="help" goto help
if /i "%command%"=="listen" goto listen
if /i "%command%"=="locate" goto locate
if /i "%command%"=="hostip" goto hostip
if /i "%command%"=="trace" goto trace
if /i "%command%"=="scan" goto scan
if /i "%command%"=="list" goto help
if /i "%command%"=="ip" goto ip
if /i "%command%"=="clear" goto clear
if /i "%command%"=="exit" goto exit
if /i "%command%"=="battery" goto battery
if /i "%command%"=="time" goto time
if /i "%command%"=="ports" goto ports
if /i "%command%"=="block" goto block
if /i "%command%"=="unblock" goto unblock
if /i "%command%"=="netsh" goto netsh
if /i "%command%"=="nslookup" goto nslookup
if /i "%command%"=="getmac" goto getmac
if /i "%command%"=="pathping" goto pathping
if /i "%command%"=="tracert" goto tracert
if /i "%command%"=="netstatus" goto netstatus
if /i "%command%"=="sysinfo" goto sysinfo
if /i "%command%"=="monitor" goto monitor

echo Lệnh không hợp lệ. Vui lòng thử lại.
goto menu

:help
cls
echo.
echo  ______  _____   _____   __        
echo /\__  _\/\  __`\/\  __`\/\ \       
echo \/_/\ \/\ \ \/\ \ \ \/\ \ \ \      
echo    \ \ \ \ \ \ \ \ \ \ \ \ \ \  __ 
echo     \ \ \ \ \ \_\ \ \ \_\ \ \ \L\ \
echo      \ \_\ \ \_____\ \_____\ \____/
echo       \/_/  \/_____/\/_____/\/___/ 
echo                                   
echo                                   
echo.
echo - listen    : Nghe các địa chỉ IP công khai
echo - locate    : Tìm vị trí của một địa chỉ IP
echo - hostip    : Chuyển đổi hostname thành địa chỉ IP
echo - trace     : Truy vết lộ trình IP
echo - scan      : Quét mạng của bạn để tìm các địa chỉ IP
echo - ports     : Quét các cổng
echo - list      : Hiển thị danh sách các lệnh
echo - ip        : Hiển thị địa chỉ IP công khai và riêng tư của bạn
echo - clear     : Xóa màn hình
echo - exit      : Thoát khỏi chương trình
echo - battery   : Kiểm tra phần trăm pin hiện tại
echo - time      : Hiển thị ngày và giờ hiện tại
echo - block     : Chặn một website
echo - unblock   : Gỡ chặn một website
echo - netsh     : Quản lý cấu hình mạng
echo - nslookup  : Kiểm tra và giải quyết hostname thành IP
echo - getmac    : Hiển thị địa chỉ MAC của máy tính
echo - pathping  : Kiểm tra đường đi và tình trạng mạng
echo - tracert   : Truy vết lộ trình tới địa chỉ IP
echo - netstatus : Kiểm tra trạng thái kết nối Internet
echo - sysinfo   : Hiển thị thông tin hệ thống
echo - monitor   : Giám sát sử dụng CPU và RAM
echo.
echo Nhập lệnh để thực hiện hoặc nhập "menu" để quay lại menu chính.
set /p "command=[help] > "
if /i "%command%"=="menu" goto menu
goto execute

:listen
cls
echo Đang nghe các địa chỉ IP công khai...
:: Add your code for listening to public IPs here
pause
goto menu

:locate
cls
set /p "ip=Nhập địa chỉ IP để tìm vị trí: "
echo Đang tìm vị trí của địa chỉ IP %ip%...
curl ipinfo.io/%ip%
pause
goto menu

:hostip
cls
set /p "hostname=Nhập hostname để chuyển đổi thành IP: "
echo Đang chuyển đổi hostname %hostname% thành IP...
nslookup %hostname%
pause
goto menu

:trace
cls
set /p "traceip=Nhập địa chỉ IP để truy vết: "
echo Đang truy vết lộ trình tới %traceip%...
tracert %traceip%
pause
goto menu

:scan
cls
echo Đang quét mạng để tìm các địa chỉ IP...
for /L %%i in (1,1,254) do ping 192.168.1.%%i -n 1 -w 100 | find "Reply"
arp -a
pause
goto menu

:ports
cls
echo Đang quét các cổng trên máy tính...
netstat -an
pause
goto menu

:list
goto help

:ip
cls
echo Địa chỉ IP công khai và riêng tư của bạn là:
curl ifconfig.me
ipconfig
pause
goto menu

:clear
cls
goto menu

:battery
cls
echo Đang kiểm tra phần trăm pin hiện tại...
for /f "tokens=2 delims==" %%i in ('wmic path win32_battery get estimatedchargeremaining /format:list') do set "battery=%%i"
echo Phần trăm pin hiện tại: %battery%%
pause
goto menu

:time
cls
:: Lấy ngày và giờ hiện tại
for /f "delims=" %%a in ('wmic os get localdatetime ^| find "."') do (
    set "dt=%%a"
)

:: Tách ngày và giờ từ chuỗi nhận được
set "year=!dt:~0,4!"
set "month=!dt:~4,2!"
set "day=!dt:~6,2!"
set "hour=!dt:~8,2!"
set "minute=!dt:~10,2!"
set "second=!dt:~12,2!"

:: Hiển thị ngày và giờ
echo Ngày giờ hiện tại: !year!-!month!-!day! !hour!:!minute!:!second!
pause
goto menu

:block
cls
set /p "website=Nhập tên website muốn chặn (ví dụ: example.com): "
echo 127.0.0.1 %website%>>%SystemRoot%\System32\drivers\etc\hosts
echo 127.0.0.1 www.%website%>>%SystemRoot%\System32\drivers\etc\hosts
ipconfig /flushdns
echo Website %website% đã bị chặn.
pause
goto menu

:unblock
cls
echo Mở tệp hosts để chỉnh sửa...
notepad C:\Windows\System32\drivers\etc\hosts
pause
goto menu

:netsh
cls
echo Quản lý cấu hình mạng...
netsh
pause
goto menu

:nslookup
cls
set /p "lookuphost=Nhập hostname để giải quyết: "
echo Đang giải quyết hostname %lookuphost% thành IP...
nslookup %lookuphost%
pause
goto menu

:getmac
cls
echo Đang hiển thị địa chỉ MAC của máy tính...
getmac
pause
goto menu

:pathping
cls
set /p "pathpingip=Nhập địa chỉ IP để kiểm tra đường đi: "
echo Đang kiểm tra đường đi và tình trạng mạng tới %pathpingip%...
pathping %pathpingip%
pause
goto menu

:tracert
cls
set /p "tracertip=Nhập địa chỉ IP để truy vết: "
echo Đang truy vết lộ trình tới %tracertip%...
tracert %tracertip%
pause
goto menu

:netstatus
cls
echo Kiểm tra trạng thái kết nối Internet...
ping www.google.com -n 1 >nul 2>&1
if errorlevel 1 (
    echo Không có kết nối Internet.
) else (
    echo Đã kết nối Internet.
)
pause
goto menu

:sysinfo
cls
echo Hiển thị thông tin hệ thống...
systeminfo
pause
goto menu

:monitor
cls
echo Giám sát sử dụng CPU và RAM...
wmic cpu get loadpercentage
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value
pause
goto menu

:exit
echo Nhấn phím bất kỳ để thoát khỏi chương trình...
pause
exit /B
