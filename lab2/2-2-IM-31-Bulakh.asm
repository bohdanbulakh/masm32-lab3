.486 
.model stdcall, flat



include \masm32\include\masm32rt.inc
option CASEmap: none 

.data 

    ; title
	BhdBulakhMessageBoxHead db "2 laboratory work, Bulakh Bohdan, IM-31", 0

BhdBulakhInfoLayoutGeneral db "ddmmyyyy: 06092005", 13
        db "Last 4 numbers of student card: 6105", 13, 13
    db "A and -A (dd - day):", 13, "A = %d",    09, "-A = %d", 13, 13
          db "B and -B (ddmm - day and month):", 13, "B = %d", 09,   "-B = %d", 13, 13
              db "C and -C (ddmmyyyy - day, month and year):", 13, "C = %d", 09, "-C = %d", 13, 13
          db    "D and -D (A/N, N - student card):", 13,   "D = %s", 09, "-D = %s", 13, 13
            db  "E and -E (B/N, N - student card):", 13, "E = %s", 09, "-E = %s", 13, 13
          db  "F and -F (C/N, N - student card):",    13, "F = %s", 09, "-F = %s", 13, 0
	
	
	; A, -A (Byte format)
	BhdBulakhPositiveByteA db 6
	BhdBulakhNegativeByteA db -6

	; A, -A (Word format)
	BhdBulakhPositiveWordA dw 6
	   BhdBulakhNegativeWordA dw -6
	
	;B, -B (Word format)
	   BhdBulakhPositiveWordB dw 609
	BhdBulakhNegativeWordB dw -609
	
	;A, -A (ShortInt format)
	   BhdBulakhPositiveShortIntA  dd 6
	BhdBulakhNegativeShortIntA dd -6
	
	; B, -B (ShortInt format)
	BhdBulakhPositiveShortIntB   dd 609
	 BhdBulakhNegativeShortIntB dd -609
	
	;C, -C (ShortInt format)
	BhdBulakhPositiveShortIntC dd 6092005
	  BhdBulakhNegativeShortIntC dd -6092005
	
	;A, -A (LongInt format)
	BhdBulakhPositiveLongIntA dq 6
    BhdBulakhNegativeLongIntA dq -6
	
	; B, -B (LongInt format)
	   BhdBulakhPositiveLongIntB dq 609
	BhdBulakhNegativeLongIntB dq -609
	
	; C, -C (LongInt  format)
	           BhdBulakhPositiveLongIntC dq 6092005
	BhdBulakhNegativeLongIntC dq -6092005
	
	; D, -D (Single (float)  format)
	BhdBulakhPositiveSingleD dd 0.001
	           BhdBulakhNegativeSingleD dd -0.001
	
	; D, -D (Double (double) format)
	   BhdBulakhPositiveDoubleD dq 0.001
	BhdBulakhNegativeDoubleD dq -0.001
	
	; E, -E (Double (double) format)
	BhdBulakhPositiveDoubleE dq 0.01
	   BhdBulakhNegativeDoubleE dq -0.01
	
	; F, -F (Double (double) format)
	BhdBulakhPositiveDoubleF dq 997.871
	BhdBulakhNegativeDoubleF dq -997.871
	
	; F, -F (Extended (long double) format)
	BhdBulakhPositiveExtendedF dt 997.871
	BhdBulakhNegativeExtendedF dt -997.871
	

; empty buffers
.data?
	BhdBulakhMessageBuffer db 512 dup (?)
	
	       BhdBulakhBufferPositiveD db 64 dup (?)

	BhdBulakhBufferNegativeD db 64 dup (?)
  BhdBulakhBufferPositiveE db 64 dup (?)
	   BhdBulakhBufferNegativeE db 64 dup (?)
	
	       BhdBulakhBufferPositiveF db 64 dup (?)
	BhdBulakhBufferNegativeF db 64 dup (?)
	
.code
start: 
	; formatting floats
	invoke FloatToStr2, BhdBulakhPositiveDoubleD, offset BhdBulakhBufferPositiveD
	invoke FloatToStr2, BhdBulakhNegativeDoubleD, offset BhdBulakhBufferNegativeD

	invoke FloatToStr2, BhdBulakhPositiveDoubleE, offset BhdBulakhBufferPositiveE
	invoke FloatToStr2, BhdBulakhNegativeDoubleE, offset BhdBulakhBufferNegativeE

	invoke FloatToStr2, BhdBulakhPositiveDoubleF, offset BhdBulakhBufferPositiveF
	invoke FloatToStr2, BhdBulakhNegativeDoubleF, offset BhdBulakhBufferNegativeF

	; formatting string message
	invoke wsprintf, offset BhdBulakhMessageBuffer, offset BhdBulakhInfoLayoutGeneral,
		BhdBulakhPositiveShortIntA, BhdBulakhNegativeShortIntA, 
	BhdBulakhPositiveShortIntB, BhdBulakhNegativeShortIntB,
	 BhdBulakhPositiveShortIntC, BhdBulakhNegativeShortIntC,
	offset BhdBulakhBufferPositiveD, offset BhdBulakhBufferNegativeD,
	   offset BhdBulakhBufferPositiveE, offset BhdBulakhBufferNegativeE,
	offset BhdBulakhBufferPositiveF, offset BhdBulakhBufferNegativeF
	
; outputting messagebox
	invoke MessageBox, NULL, offset BhdBulakhMessageBuffer, offset BhdBulakhMessageBoxHead, 0
	invoke ExitProcess, 0

end start