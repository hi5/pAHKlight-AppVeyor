@echo off
set err_level=0

REM If no arguments are passed just exit
IF "%~1"=="" GOTO EXIT

REM /ErrorStdOut Send syntax errors that prevent a script from launching 
REM to stderr rather than displaying a dialog. See #ErrorStdOut for details. 
REM Combined with /iLib to validate the script without running it.

start "testing" /B /wait "C:\Program Files\AutoHotkey\AutoHotkeyU32.exe" /iLib NUL /ErrorStdOut %1% > testoutput.txt 2>&1
echo ** Validating %1% **
if errorlevel 1 (
	echo *** Test file %1% failed ***
	set err_level=1
	)
type testoutput.txt
echo.
)

:EXIT
rem EXIT SCRIPT
exit /b %err_level%
