@echo off
set err_level=0

rem Loop over all ahk files in tests directory
for /r %%i in (*.ahk) do (
	start "testing" /B /wait "C:\Program Files\AutoHotkey\AutoHotkeyU32.exe" /ErrorStdOut %%~nxi > testoutput.txt 2>&1
	echo ** Running %%~nxi **
	if errorlevel 1 (
		echo *** Test file %%~nxi failed ***
		set err_level=1
	)
	type testoutput.txt
	echo.
)

rem EXIT SCRIPT
exit /b %err_level%
