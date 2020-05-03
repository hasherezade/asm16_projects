@echo off

tasm.exe main.asm
if %errorlevel% NEQ 0 (
pause
goto exit1
)

tlink main.obj
if %errorlevel% NEQ 0 (
pause
goto exit1
)
:exit1

