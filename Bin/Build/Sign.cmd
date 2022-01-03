set SignCmd=e:\lite\cert\sign\signfile.cmd

call %SignCmd% ..\Win32\AriaNg.exe
call %SignCmd% ..\Win64\AriaNg.exe

goto End

:Error1
color 04
echo Sign Error!
goto End

:End
color 0a
echo Sign Done!
pause
