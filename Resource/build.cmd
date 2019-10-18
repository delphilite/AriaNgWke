set PATH=%PATH%;"C:\Program Files\CodeGear\RAD Studio\5.0\bin";"C:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin"
set PATH=%PATH%;"C:\Program Files\Embarcadero\RAD Studio\9.0\bin";"C:\Program Files (x86)\Embarcadero\RAD Studio\9.0\bin"

del Aria2ControlFrm.res
del Aria2ControlFrm.rc

echo INDEX RCDATA index.html    >  Aria2ControlFrm.rc

brcc32 -l0409 Aria2ControlFrm.rc
ren Aria2ControlFrm.res Aria2ControlFrm.res

del Aria2ControlFrm.rc

copy /y Aria2ControlFrm.res ..\Source\Aria2ControlFrm.res

pause
