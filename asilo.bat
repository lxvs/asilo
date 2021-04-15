@setlocal enableextensions enabledelayedexpansion

@REM App Silo v1.0.0
@REM Johnny Appleseed <jn.apsd+batch@gmail.com>

@REM === Customization Start ===

@REM When app_x failed to start, if app_x_critical=true, whole series stop.

@set "app_1=spotify"
@set "app_1_path=%USERPROFILE%"
@set /a delay_sec_1=5
@set "app_1_critical=true"

@set "app_2=SSTap.exe"
@set "app_2_path=%LOCALAPPDATA%\SSTap-beta\"
@set /a delay_sec_2=20
@set "app_2_critical=true"

@set "app_3=Battle.net.exe"
@set "app_3_path=%PROGRAMFILES(x86)%\Battle.net\"
@set /a delay_sec_3=0
@set "app_3_critical=true"

@REM === Customization End =====

@(call )
@REM reset errorlevel

@set /a index=1
:loop
@if not defined app_%index% exit /b 0
@echo starting [!app_%index%!]
@start "" /D "!app_%index%_path!" "!app_%index%!" || (
    if "!app_%index%_critical!" == "true" (
        @echo;
        @echo [!app_%index%!] failed to start
        @echo since [!app_%index%!] is set to [critical], script stops.
        @pause
        @exit /b
    )
)

@echo ^> Waiting ^(!delay_sec_%index%! sec^)...
@set /a "delay_%index%=delay_sec_%index%+1"
@ping localhost -n !delay_%index%! 1>nul 2>&1

@set /a index+=1
@echo;
@goto loop
