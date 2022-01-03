del /q AriaNgWke-Win32.7z
7za a AriaNgWke-Win32.7z ..\Win32\AriaNg.exe ..\Win32\Wke.dll
IF NOT EXIST AriaNgWke-Win32.7z goto Error1

del /q AriaNgWke-Win64.7z
7za a AriaNgWke-Win64.7z ..\Win64\AriaNg.exe ..\Win64\Wke.dll
IF NOT EXIST AriaNgWke-Win64.7z goto Error1

goto End

:Error2
color 04
echo Pack Error!
goto End

:End
color 0a
echo Pack Done!
pause
