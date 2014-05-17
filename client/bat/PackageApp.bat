@echo off
set PAUSE_ERRORS=1
call SetupSDK.bat
call SetupApplication.bat

set AIR_TARGET=
::set AIR_TARGET=-captive-runtime
set OPTIONS=-tsa none
call Packager.bat

pause