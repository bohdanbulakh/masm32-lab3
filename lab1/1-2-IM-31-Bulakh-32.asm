.386
.model flat, stdcall

option casemap:none

include \masm32\include\windows.inc 
include \masm32\include\user32.inc            
include \masm32\include\kernel32.inc   
  
includelib \masm32\lib\user32.lib  
includelib \masm32\lib\kernel32.lib  
    
.data  
    BohdanBulakhMessageBoxHeader db   "MASM32 ����������� ������ 1 ����� ������", 0  
        BohdanBulakhMessageBoxContent db "ϲ� - ����� ������ ����������", 10   
      db "���� ���������� - 06.09.2005", 10  
            db "����� ������� ������ - 4237", 0  
  
.code  
BohdanBulakhMessageBox: 
    invoke MessageBox, NULL,   
           addR BohdanBulakhMessageBoxContent,      
         AddR BohdanBulakhMessageBoxHeader, MB_OK 
    
    INVOKE  ExitProcess, 0 
       
end BohdanBulakhMessageBox 
  