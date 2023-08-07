
    ;; Get current explosion sfx frame; if not set, skip this
    LDY sfx_timer
    BEQ +done
    
        ;; Check if explosion sfx is done; if so, disable and skip
        LDA (sfx_address),y
        BNE +
            LDA #$00
            STA sfx_timer
            JMP +done
        +
        
        ;; Set low nibble as volume
        AND #$0F
        ORA #$30
        STA NOISE_VOLUME
        
        ;; Set high nibble as frequency
        LDA (sfx_address),y
        LSR
        LSR
        LSR
        LSR
        EOR #$0F
        STA NOISE_PERIOD
        
        ;; Next frame
        INC sfx_timer
    +done

