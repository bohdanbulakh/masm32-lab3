@echo off

ML /c /coff "7-2-IM-31-Bulakh.asm"

ML /c /coff "7-2-IM-31-Bulakh-PUB.asm"

link32 /subsystem:windows "7-2-IM-31-Bulakh.obj" "7-2-IM-31-Bulakh-PUB.obj"

7-2-IM-31-Bulakh.exe