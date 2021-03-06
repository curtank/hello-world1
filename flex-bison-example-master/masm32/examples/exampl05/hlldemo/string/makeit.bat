@echo off

if not exist rsrc.rc goto over1
\masm32\bin\rc /v rsrc.rc
\masm32\bin\cvtres /machine:ix86 rsrc.res 
:over1 
 
if exist "string.obj" del "string.obj"
if exist "string.exe" del "string.exe"

\masm32\bin\ml /c /coff "string.asm"
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

\masm32\bin\Link /SUBSYSTEM:WINDOWS "string.obj" rsrc.obj 
 if errorlevel 1 goto errlink

dir "string.*"
goto TheEnd

:nores 
\masm32\bin\Link /SUBSYSTEM:WINDOWS "string.obj" 
if errorlevel 1 goto errlink
dir "string.*"
goto TheEnd

:errlink 
 echo _
echo Link error
goto TheEnd

:errasm 
 echo _
echo Assembly Error
goto TheEnd

:TheEnd 
 
pause
