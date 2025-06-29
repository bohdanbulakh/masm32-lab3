

BohdanBulakhValidatePassword macro

    mov esi, 0
            mov ecx, 9
        ;; a loop for password decrypting
            BohdanBulakhDecryptLoop:
                mov al, [BohdanBulakhEncryptedPassword + esi]
                xor al, [BohdanBulakhXorKey + esi] ; using of xor
                mov [BohdanBulahlDecryptedPassword + esi], al
                
                inc esi
                loop BohdanBulakhDecryptLoop
 
endm




BohdanBulakhComparePasswds macro userPasswd, decryptedOriginalPasswd
    ;; it's an important hidden comment

    local checkPasswd ; this is a local label
    checkPasswd:
          invoke lstrcmp, offset userPasswd, \
                            offset decryptedOriginalPasswd
endm




BohdanBulakhMessageBox macro text, title
   ;; some hidden comment
	invoke MessageBox, 0, offset text, \
            offset title, 0 ; invoking of MessageBox
endm 