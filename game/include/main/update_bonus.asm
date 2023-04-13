;; update_bonus.asm

    ;; If bonus = 000, skip decreasing
    LDA ball_bonus
    CLC
    ADC ball_bonus+1
    CLC
    ADC ball_bonus+2
    BEQ +done

    ;; Check if bonus counter is done yet
    LDA bonus_counter
    BNE +done

    ;; Bonus counter is done
    ;; Reset bonus counter
    LDA #BONUS_FRAMES
    STA bonus_counter
    
    ;; Subtract one from ball bonus ones
    DEC ball_bonus+2
    
    ;; Check if underflow
    BPL +updateBonusOnScreen

    ;; If underflow, set 9 and subtract one from bonus tens
    LDA #$09
    STA ball_bonus+2
    DEC ball_bonus+1
    
    ;; Check if underflow
    BPL +updateBonusOnScreen

    ;; If underflow, set 9 and subtract one from bonus hundreds
    LDA #$09
    STA ball_bonus+1
    DEC ball_bonus

    ;;209A 209B 209C
+updateBonusOnScreen:
    LDA #$20
    STA temp
    LDA #$9C
    STA temp+1
    LDX #$02
    
    -updateNextDigit:
        LDA ball_bonus,x
        CLC
        ADC #$01
        STA temp+2
        JSR sub_WriteByteToPPUBuffer
        DEC temp+1
        DEX
    BPL -updateNextDigit
        
+done: