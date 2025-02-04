if "%~1"=="-fcc" (
   SHIFT
) ELSE (
   CALL <NUL %0 -fcc %*
   GOTO :EOF
)
IF NOT DEFINED BASEBOX (SET BASEBOX=dosbox)
set OLD_PATH=%cd%
cd /D %LOCAL_ROOT%\gbuild\localpc 
start /B %BASEBOX% -conf %ROOT_DIR%\bin\basebox.conf -noconsole
cd %OLD_PATH%
sleep 2s
FINDSTR /r /c:"127.0.0.1 from port" %LOCAL_ROOT%\gbuild\localpc\IPX_STAT.txt | perl -e "my $status = <>; $status =~  m/(\d+)$/; printf('%%04X', $1);" > %LOCAL_ROOT%\gbuild\localpc\IPX_PORT.txt
set /p IPX_PORT=<%LOCAL_ROOT%\gbuild\localpc\IPX_PORT.txt
cls
mode 120,50
IF EXIST "%USERPROFILE%\swat.rc" (
   set CUSTOM_TCL_LOCATION=%USERPROFILE%\swat.rc
) ELSE IF EXIST "%cd%\swat.rc" (
   set CUSTOM_TCL_LOCATION=%cd%\swat.rc
) ELSE (
   set CUSTOM_TCL_LOCATION=
)
swat -net 00000000:7F000001%IPX_PORT%:003F
