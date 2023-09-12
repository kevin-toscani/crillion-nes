
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
        LDA tbl_MoveSfxVolume,y
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
    +done:


    ;; Check paint sfx
    LDY sfx_timer+2
    BEQ +done

        DEC sfx_timer+2
        CPY #$10
        BNE +
            ;; Update APU status
            LDA #$09
            STA APU_STATUS
        +
        
        ;; Set volume
        LDA tbl_PaintSfxVolume,y
        STA PULSE1_VOLUME
        LDA tbl_PaintSfxFreqLo,y
        STA PULSE1_TIMER_LO
        LDA tbl_PaintSfxFreqHi,y
        STA PULSE1_TIMER_HI
    +done:


    ;; Check sweep sfx
    LDA sfx_sweep_count
    BEQ +done
        CMP #$0F
        BNE +
            LDA #$01
            STA APU_STATUS
        +
        LDA sfx_sweep_volume
        ORA #$70
        STA PULSE1_VOLUME
        LDA sfx_sweep_frequency
        STA PULSE1_TIMER_LO
        LDA #$08
        STA PULSE1_TIMER_HI
    +done:
    
    
    ;; Check end game sweep
    LDA sfx_endgame_enabled
    BEQ +done
        CMP #$01
        BNE +
            LDA #$03
            STA APU_STATUS
            INC sfx_endgame_enabled
        +
        
        CMP #$FF
        BNE +
            LDA #$00
            STA sfx_endgame_enabled
            STA APU_STATUS
            STA PULSE1_VOLUME
            STA PULSE2_VOLUME
            JMP +done
        +
        LDA #$77
        STA PULSE1_VOLUME
        STA PULSE2_VOLUME
        LDA sfx_endgame_p1_freq_hi
        STA PULSE1_TIMER_HI
        LDA sfx_endgame_p1_freq_lo
        STA PULSE1_TIMER_LO 
        LDA sfx_endgame_p2_freq_hi
        STA PULSE2_TIMER_HI
        LDA sfx_endgame_p2_freq_lo
        STA PULSE2_TIMER_LO
    +done:

