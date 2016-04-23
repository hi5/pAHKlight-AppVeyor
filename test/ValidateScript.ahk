; Code by Lexikos @ http://autohotkey.com/board/topic/129196-proper-error-handling-when-compiling-exit-code-and-stdout/?p=706370
; Given a script path, the ValidateScript function should return either an empty string or a filename, line number and error message

SetWorkingDir, %A_ScriptDir%

Loop, *.ahk
	{
	 if (A_LoopFileName = A_ScriptName)
	 	Continue
	 if !ValidateScript(A_LoopFileName, error, warnings)
	 	FileAppend,*** %A_LoopFileName% ***`n Fail`n`nError: %error%`n`nWarnings:`n%warnings%`n`n------------------------------------------------`n`n, *
	}

IfExist, testoutput.txt
	{
	 Send type testoutput.txt{enter}
	 ExitCode:=1
	}

ExitApp, %ExitCode%

ValidateScript(path, ByRef error := "", ByRef warnings := "") {
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec("AutoHotkey.exe /iLib NUL /ErrorStdOut *")
    warn := IsByRef(warnings) ? "StdOut" : "Off"
    script =
    (LTrim
    #Include %path%
    #Warn,, %warn%
    )
    exec.StdIn.Write(script)
    exec.StdIn.Close()
    error := exec.StdErr.ReadAll()
    warnings := exec.StdOut.ReadAll()
    return exec.ExitCode != 2 && warnings = ""
}
