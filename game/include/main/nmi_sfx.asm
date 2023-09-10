
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
    +done:


    ;; Check move sfx
    LDY sfx_timer+1
    BEQ +done

        DEC sfx_timer+1
        CPY #$18
        BNE +
            ;; Update APU status
            LDA #$09
            STA APU_STATUS
            LDA #$8B
            STA sfx_frequency
            LDA #$0A
            STA sfx_frequency+1
        +
        
        ;; Set volume
        LDA #$70
        ORA tbl_MoveSfxVolume,y
        STA PULSE1_VOLUME
        
        STY temp
        LDA #$18
        SEC
        SBC temp
        LSR
        CLC
        ADC #$03
        ADC sfx_frequency
        STA sfx_frequency
        STA PULSE1_TIMER_LO
        LDA sfx_frequency+1
        ADC #$00
        STA sfx_frequency+1
        STA PULSE1_TIMER_HI
        
        CPY #$01
        BNE +done

        ;; Disable
        LDA #$00
        STA $4001
        
    +done:
