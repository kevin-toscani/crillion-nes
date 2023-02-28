@echo off
asm6f -m crillion.asm output\crillion.nes output\crillion.txt 1>output\crillion.log 2>&1
if exist output\crillion.nes (
    "C:\Program Files (x86)\Mesen\Mesen.exe" output\crillion.nes
) else (
    notepad output\crillion.log
)
echo on