@echo off
title ByeDPI - Install Service
pushd "%~dp0"

echo This script should be run with administrator privileges.
echo Right click - run as administrator.
echo Press any key if you're running it as administrator.
pause

set svc_name="ByeDPI"
set svc_desc="Local SOCKS proxy server to bypass DPI (Deep Packet Inspection)."

:: Set up launch args (bypass methods) here. The "--service" arg is required; 
:: without it, the program will not register itself as a Windows service!
set svc_bin="\"%cd%\ciadpi.exe\" --service --split 1+s --disorder 3+s --mod-http=h,d --auto --tlsrec 1+s"

sc stop %svc_name%
sc delete %svc_name%
sc create %svc_name% binPath= %svc_bin% start= "auto"
sc description %svc_name% %svc_desc%
sc start %svc_name%

popd
pause