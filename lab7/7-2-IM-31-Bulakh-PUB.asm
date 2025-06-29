.386
.model flat, stdcall
option casemap:none

public BohdabBulakhCalcDenominator
extern BohdanBulakh4Const:qword, BohdanBulakhA:qword, BohdanBulakhB:qword

.code
BohdabBulakhCalcDenominator proc
	fld BohdanBulakhA[esi * 8]
    
    	fdiv BohdanBulakh4Const
   	 

    	   fld BohdanBulakhB[esi * 8]
    	fsub
	
	   fptan
	ret
BohdabBulakhCalcDenominator endp
end