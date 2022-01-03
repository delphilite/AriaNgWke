call "%ProgramFiles(x86)%\Embarcadero\RAD Studio\9.0\bin\rsvars.bat"

del ..\Win32\AriaNg.exe
msbuild ..\..\Source\AriaNg.dproj /target:Build /p:config=Release /p:platform=Win32 /nologo
IF NOT EXIST ..\Win32\AriaNg.exe goto Error1

del ..\Win64\AriaNg.exe
msbuild ..\..\Source\AriaNg.dproj /target:Build /p:config=Release /p:platform=Win64 /nologo
IF NOT EXIST ..\Win64\AriaNg.exe goto Error1

goto End

:Error1
color 04
echo Compile Error!
goto End

:End
color 0a
echo Build Done!
pause
