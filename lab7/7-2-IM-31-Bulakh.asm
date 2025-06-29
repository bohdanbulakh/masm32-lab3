.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\dialogs.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

public BohdanBulakh4Const, BohdanBulakhA, BohdanBulakhB
extern BohdabBulakhCalcDenominator:proto

.const
	BohdanBulakhMinus2Const            	dq -2.0
   BohdanBulakh4Const                	dq 4.0
	BohdanBulakhConstPi                	dq 3.141592
    	BohdanBulakh82Const        	dq 82.0
	BohdanBulakhConstHalfPi            	dq 1.570796

.data
	BohdanBulakhFromulaInfo        	db "Формула: (-2 * c - d * 82) / tg(a / 4 - b)", 10, 10,
                                    	"A = %s", 10,
                                    	"B = %s", 10,
                                    	"C = %s", 10,
                                    	"D = %s", 10,
                                    	"Вираз - (-2 * %s - %s * 82) / tg(%s / 4 - %s)", 10, 10,
                                    	"%s", 0

	BohdanBulakhResultStrText    	db "Результат: %s", 0

	BohdanBulakhA         	dq -10.3, -2.8, 1.6, 5.5, 4.0, 12.56637, 6.28319
	BohdanBulakhB         	dq 6.8, 2.0, 4.3, 2.2, 1.0, 1.8, 0.0
    
	BohdanBulakh0DivError	db "Помилка: ділення на 0", 0    
    	BohdanBulakhMessageBoxTitle            	db "Лабороаторна робота 7", 0
	BohdanBulakhTanError    	db "Помилка: значення виходить за область визначення тангенса", 0
    
    

	BohdanBulakhCurrentStrC        	db 128 dup (?)    
   BohdanBulakhCurrentStrA        	db 128 dup (?)
	BohdanBulakhCurrentStrB        	db 128 dup (?)
	BohdanBulakhCurrentStrD        	db 128 dup (?)
	BohdanBulakhStrResultNum        	db 128 dup (?)

	BohdanBulakhC        	dq 2.1, 4.5, -3.8, 4.1, 2.5, 1.8, 2.7
	BohdanBulakhD        	dq -0.6, 0.9, -0.7, 2.7, 3.75, 2.4, 5.3

    

	BohdanBulakhMessageBoxContent            	db 256 dup (?)
	BohdanBulakhSuccessResultText        	db 256 dup (?)
    

    
  	BohdanBulakhArgOfTg             	dt ?
	BohdanBulakhResultNumerator                   	dt ?

	BohdanBulakhResultDenominator                   	dt ?
       	BohdanBulakhFirstMulNumer    	dt ?
	BohdanBulakhSecondMulDenom 	dt ?
  	BohdanBulakhRem            	dt ?
	BohdanBulakhFloatResult                	dq ?


BohdanBulakhValidateTanArg macro

fld BohdanBulakhA[esi * 8]
    
    	fdiv BohdanBulakh4Const
   	 

    	   fld BohdanBulakhB[esi * 8]
    	fsub
		
	    	fstp BohdanBulakhArgOfTg

fld BohdanBulakhArgOfTg
    
    	fldz
    
    	   fcom
    
      	fnstsw ax
    
    	sahf
    
       	jz BohdanBulakh0Error
     	 
    	fld     BohdanBulakhArgOfTg
    
    	fsub BohdanBulakhConstHalfPi
   	 

    	fld BohdanBulakhConstPi
    	fprem
    
    	  fistp     DWord ptr [BohdanBulakhRem]


    	cmp     DWORD ptr [BohdanBulakhRem], 0
    
    	je BohdanBulakhTanShowError

endm


.code
BohdanBulakhCalcFirstPart proc
      fld   qword ptr [ebx]  
    fmul  BohdanBulakhMinus2Const
      fstp BohdanBulakhFirstMulNumer  
    ret
BohdanBulakhCalcFirstPart endp


BohdanBulakhCalcSecondPart proc
    push ebp
      mov ebp, esp
    
       mov edx, [ebp+8]         
    
      fld qword ptr [edx]     
     fmul BohdanBulakh82Const  
       fstp BohdanBulakhSecondMulDenom 
        
      pop ebp
     ret 4          
BohdanBulakhCalcSecondPart endp



lab:
	mov esi, 0
	BohdanBulakhLoop:


       	invoke FloatToStr,     BohdanBulakhA[esi * 8],
    addr BohdanBulakhCurrentStrA
    
    	invoke   FloatToStr, BohdanBulakhB[esi * 8], 
     addr BohdanBulakhCurrentStrB
    	invoke FloatToStr, 
      BohdanBulakhC[esi * 8],  
    addr BohdanBulakhCurrentStrC
    	invoke FloatToStr,   
     BohdanBulakhD[esi * 8], addr BohdanBulakhCurrentStrD
    
    	finit

   	 
        lea ebx, BohdanBulakhC[esi*8] 
        call BohdanBulakhCalcFirstPart
        

        lea eax, BohdanBulakhD[esi*8]
        push eax          
        call BohdanBulakhCalcSecondPart
        

        fld BohdanBulakhFirstMulNumer
        fld BohdanBulakhSecondMulDenom
        fsub
        fstp BohdanBulakhResultNumerator
    
   	 


    	

BohdanBulakhValidateTanArg
		
		call BohdabBulakhCalcDenominator

   	 
 	fstp st(0)
 
    	 fstp BohdanBulakhResultDenominator

    	  fld BohdanBulakhResultNumerator
    
    	   fld BohdanBulakhResultDenominator
    
    	 fdiv
    
    	fstp BohdanBulakhFloatResult
   	 
    	  invoke FloatToStr, BohdanBulakhFloatResult, addr BohdanBulakhStrResultNum

    	invoke wsprintf, addr BohdanBulakhSuccessResultText, addr BohdanBulakhResultStrText, addr BohdanBulakhStrResultNum
   	 

    	invoke wsprintf, addr BohdanBulakhMessageBoxContent, addr BohdanBulakhFromulaInfo,
        	addr  BohdanBulakhCurrentStrA, addr BohdanBulakhCurrentStrB, 
addr BohdanBulakhCurrentStrC, addr BohdanBulakhCurrentStrD,
  	addr   BohdanBulakhCurrentStrC, 
  addr BohdanBulakhCurrentStrD,  addr BohdanBulakhCurrentStrA, addr BohdanBulakhCurrentStrB,
addr BohdanBulakhSuccessResultText


    
jmp BohdanBulakhShowResult

    	BohdanBulakh0Error:
        	invoke wsprintf, addr BohdanBulakhMessageBoxContent, 
        addr BohdanBulakhFromulaInfo,
            	addr     BohdanBulakhCurrentStrA, 
            addr      BohdanBulakhCurrentStrB,
             addr    BohdanBulakhCurrentStrC,     addr   BohdanBulakhCurrentStrD,
            	addr     BohdanBulakhCurrentStrC, addr BohdanBulakhCurrentStrD, 
            addr BohdanBulakhCurrentStrA,    addr    BohdanBulakhCurrentStrB,
            	addr   BohdanBulakh0DivError


        	jmp BohdanBulakhShowResult

BohdanBulakhShowResult:
        	invoke MessageBox, 0, addr BohdanBulakhMessageBoxContent, addr BohdanBulakhMessageBoxTitle, 0
   	 
        	jmp BohdanBulakhCheckIteration
   	 
   	 
       	 
    	BohdanBulakhTanShowError:
        	invoke wsprintf, addr BohdanBulakhMessageBoxContent,    addr BohdanBulakhFromulaInfo,
            	     addr    BohdanBulakhCurrentStrA, addr          BohdanBulakhCurrentStrB, 
                addr     BohdanBulakhCurrentStrC, addr       BohdanBulakhCurrentStrD,
            	addr                  BohdanBulakhCurrentStrC,      addr BohdanBulakhCurrentStrD, 
               addr        BohdanBulakhCurrentStrA,      addr BohdanBulakhCurrentStrB,
            	addr BohdanBulakhTanError
            
        	jmp BohdanBulakhShowResult


BohdanBulakhCheckIteration:
	inc esi
        	.if esi < 7  
jmp BohdanBulakhLoop  
         	.else
	invoke ExitProcess, 0
        	.endif

end lab