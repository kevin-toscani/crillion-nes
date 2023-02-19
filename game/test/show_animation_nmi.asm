    ;; Reset sprite RAM, draw sprites
    STA OAM_ADDR
    LDA #$02
    STA OAM_DMA

    LDY #MAX_ANIMATIONS
    LDX #$00
    -
        LDA explosion_framecounter,x
        BEQ +
            DEC explosion_framecounter,x
        +
        INX
        DEY
        BEQ +done        
    JMP -
+done:
    
    LDA nudge_counter
    BEQ +
        DEC nudge_counter
    +
