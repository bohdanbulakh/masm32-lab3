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
    BohdanBulakhaArray    dd -1,  1,  -2,   5,   2
    BohdanBulakhbArray    dd  1,   2,   4,  4,   1
    BohdanBulakhcArray    dd  3,  1,  -5,   -3,  -2

    BohdanBulakhResult   dd ?
    BohdanBulakhMessageBoxInfo   db 512 dup(0)
    BohdanBulakhMessageBoxResult  db 64 dup(0)
    
   BohdanBulakhResultMessage db "Проміжний результат: %d", 10,
						"Результат: %d",   0

    BohdanBulakhInfoMessage    db  "Формула: (-25/a + c - b*a)/(1 + c*b/2)", 10, 10,
					"A: %d", 10,
						"B: %d", 10,
							"C: %d", 10,
						"Обчислення: (-25/%d + %d - %d*%d)/(1 + %d*%d/2)", 10, 10,
								"%s", 0
	
    BohdanBulakhTitle  db  "Лабораторна робота 5", 0
    BohdanBulakhErrorMessage    db "Помилка: ділення на нуль у знаменнику!",0

.code
start:
    xor edi, edi

calcLoop:
    mov   eax, -25
      cdq
        idiv       dword ptr BohdanBulakhaArray[edi*4]
      mov   ebx, eax

     add   ebx, dword ptr BohdanBulakhcArray[edi*4]

    mov   eax, dword ptr BohdanBulakhbArray[edi*4]
    
      mov   edx,   dword ptr BohdanBulakhaArray[edi*4]
    imul   eax, edx
      
       sub    ebx,  eax

     mov   eax,    BohdanBulakhcArray[edi*4]
    mov      edx,     BohdanBulakhbArray[edi*4]
    
     imul  eax, edx
    sar   eax, 1
    
       add   eax, 1
    mov   ecx, eax


    .if ecx == 0
        invoke wsprintf, offset BohdanBulakhMessageBoxResult, offset BohdanBulakhErrorMessage
    .else
     
        mov   eax, ebx
        cdq
        idiv  ecx
        mov   ebx, eax  

 
        mov   edx, eax
        and   edx, 1

        .if edx == 0
            sar eax, 1
        .else
            imul eax, ebx, 5
        .endif


        mov BohdanBulakhResult, eax

  
        invoke wsprintf, offset BohdanBulakhMessageBoxResult, offset BohdanBulakhResultMessage,
               ebx, eax
    .endif

 
    invoke wsprintf, offset BohdanBulakhMessageBoxInfo, offset BohdanBulakhInfoMessage,
               BohdanBulakhaArray[edi*4],     BohdanBulakhbArray[edi*4], 
        BohdanBulakhcArray[edi*4], BohdanBulakhaArray[edi*4], BohdanBulakhcArray[edi*4], BohdanBulakhbArray[edi*4],
           BohdanBulakhaArray[edi*4], BohdanBulakhcArray[edi*4],   BohdanBulakhbArray[edi*4],  offset BohdanBulakhMessageBoxResult


        invoke MessageBox, NULL, offset BohdanBulakhMessageBoxInfo, offset BohdanBulakhTitle, MB_OK

    inc edi
    
    cmp  edi, 5
    jl calcLoop

    invoke ExitProcess, 0
end start
