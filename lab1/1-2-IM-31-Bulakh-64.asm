option DOTNAME
OPTION casemap :none 

include \masm64\include\temphls.inc  
include \masm64\include\win64.inc 
include \masm64\include\user32.inc 
include \masm64\include\kernel32.inc 

includelib \masm64\lib\user32.lib  
includelib \masm64\lib\kernel32.lib   
    
.data 
 
    BohdanBulahMessageBoxHeader    db "MASM64 ����������� ������ 1 ����� ������", 0
  BohdanBulakhMessageBoxContent        db "ϲ� - ����� ������ ����������", 10
             db "���� ���������� - 06.09.2005", 10
        db "����� ������� ������ - 4237", 0

.code
WinMain   proc
  sub rsp  , 28h  
    invoke MessageBox, 0 , addr BohdanBulakhMessageBoxContent, addr BohdanBulahMessageBoxHeader , 0                  
       
    invoke ExitProcess, NULL
WinMain endp 
  
end 