.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\dialogs.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib


.data
	BohdanBulakhCorrectPassword			db "BohdanBul", 0	

            BohdanBulakhWrongWindowText		db "This password is incorrect", 13, 10,
                                            "Try again", 0

	BohdanBulakhCorrectWindowTitle		db "Password is correct!", 0


	BohdanBulakhWrongWindowTitle		db "Incorrect password", 0

	
	BohdanBulakhUserPassword	db 32	dup (?)

	BohdanBulakhCorrectWindowText		db "Full name of student: Bulakh Bohdan Valeriyovych", 13, 10,
									"Birth date: 06.09.2005", 13, 10,
									"Student card: 4237", 0

.code

BohdanBulakhExit proc
	invoke ExitProcess, 0

BohdanBulakhExit endp

BohdanBulakhResultMessageBox proc isPasswordValid:dword

  .if isPasswordValid != 0
	invoke MessageBox, 0, offset BohdanBulakhWrongWindowText, \
            offset BohdanBulakhWrongWindowTitle, 0
   
   .else
	invoke MessageBox, 0, offset BohdanBulakhCorrectWindowText, \
            offset BohdanBulakhCorrectWindowTitle, 0
   
    .endif

    ret
        
BohdanBulakhResultMessageBox endp


BohdanBulakhHandler proc BohdanBulakhWindowHandle:dword, BohdanBulakhUnit:dword, BohdanBulakhAction:dword, BohdanBulakhP:dword
	
   .if BohdanBulakhUnit == WM_COMMAND
		.if BohdanBulakhAction == IDOK
			invoke GetDlgItemText, BohdanBulakhWindowHandle, 1200, \
                            addr BohdanBulakhUserPassword, 512
			
                  invoke lstrcmp, offset BohdanBulakhUserPassword, \
                            offset BohdanBulakhCorrectPassword
			
                  invoke BohdanBulakhResultMessageBox, eax
                  
		.elseif BohdanBulakhAction == IDCANCEL
			invoke BohdanBulakhExit
		.endif
			
	.elseif BohdanBulakhUnit == WM_CLOSE
		invoke BohdanBulakhExit
	.endif

		mov eax, 0
      ret
BohdanBulakhHandler endp

start:
	Dialog "Laboratory 3, not encrypted", "Arial", 12, \
        WS_SYSMENU or WS_OVERLAPPED or DS_CENTER, \
        4, \
        100, 100, 130, 90, \
        1024
        				
	DlgStatic "Write password here:", SS_CENTER, \
            1, 10, 115, 12, \
            445

	DlgEdit WS_BORDER, \
            6, 25, 115, 12, \
            1200

	DlgButton "Cancel", WS_TABSTOP, \
            19,   50, 35,  15, \
            IDCANCEL 

	DlgButton "OK", WS_TABSTOP, \
            78, 50, 35, 15, \
            IDOK
	
	CallModalDialog 0, 0, BohdanBulakhHandler, NULL

end start