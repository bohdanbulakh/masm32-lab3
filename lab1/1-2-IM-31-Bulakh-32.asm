.386
.model flat, stdcall

option casemap:none

include \masm32\include\windows.inc 
include \masm32\include\user32.inc            
include \masm32\include\kernel32.inc   
  
includelib \masm32\lib\user32.lib  
includelib \masm32\lib\kernel32.lib  
    
.data  
    BohdanBulakhMessageBoxHeader db   "MASM32 Лабораторна робота 1 Булах Богдан", 0  
        BohdanBulakhMessageBoxContent db "ПІБ - Булах Богдан Валерійович", 10   
      db "Дата народження - 06.09.2005", 10  
            db "Номер залікової книжки - 4237", 0  
  
.code  
BohdanBulakhMessageBox: 
    invoke MessageBox, NULL,   
           addR BohdanBulakhMessageBoxContent,      
         AddR BohdanBulakhMessageBoxHeader, MB_OK 
    
    INVOKE  ExitProcess, 0 
       
end BohdanBulakhMessageBox 
  