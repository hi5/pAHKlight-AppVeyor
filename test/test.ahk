/*
This file shows a custom, barebones test script made functional without using any other libs
*/

global errorcode := 0

/*
Tests
*/

FileRea, data, %A_ScriptFullPath%

Loop, parse, data, `n, `r
	counter++

