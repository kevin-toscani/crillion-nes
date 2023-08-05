
    ;; Get current explosion sfx frame; if not set, skip this
    LDX explosion_sfx_timer
    BEQ +done
    
        ;; Check if explosion sfx is done; if so, disable and skip
        LDA tbl_ExplosionSfx, x
        CMP #$FF
        BNE +
            LDA #$00
            STA explosion_sfx_timer
            JMP +done
        +
        
        ;; Set low nibble as volume
        AND #$0F
        ORA #$30
        STA NOISE_VOLUME
        
        ;; Set high nibble as frequency
        LDA tbl_ExplosionSfx, x
        LSR
        LSR
        LSR
        LSR
        EOR #$0F
        STA NOISE_PERIOD
        
        ;; Next frame
        INC explosion_sfx_timer
    +done