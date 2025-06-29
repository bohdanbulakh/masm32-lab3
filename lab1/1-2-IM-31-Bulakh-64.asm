option DOTNAME
OPTION casemap :none 

include \masm64\include\temphls.inc  
include \masm64\include\win64.inc 
include \masm64\include\user32.inc 
include \masm64\include\kernel32.inc 

includelib \masm64\lib\user32.lib  
includelib \masm64\lib\kernel32.lib   
    
.data 
 
    BohdanBulahMessageBoxHeader    db "MASM64 Лабораторна робота 1 Булах Богдан", 0
  BohdanBulakhMessageBoxContent        db "ПІБ - Булах Богдан Валерійович", 10
             db "Дата народження - 06.09.2005", 10
        db "Номер залікової книжки - 4237", 0

.code
WinMain   proc
  sub rsp  , 28h  
    invoke MessageBox, 0 , addr BohdanBulakhMessageBoxContent, addr BohdanBulahMessageBoxHeader , 0                  
       
    invoke ExitProcess, NULL
WinMain endp 
  
end 