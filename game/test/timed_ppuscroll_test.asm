;; Timed updates (test)

    ;; If B button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BEQ +end
    
    ;; Set up loop fading
    LDA #$00
    STA temp+7
    LDY #$08
    -fadeLoop:
        STY temp+8

        ;; Wait for NMI to pass
        JSR sub_WaitForVBlank
        
        ;; Now wait for No-sprite 0
        -
            LDA PPU_STATUS
            AND #SPRITE_0_HIT
        BNE -
    
        ;; Now wait for Sprite 0
        -
            LDA PPU_STATUS
            AND #SPRITE_0_HIT
        BEQ -
            
        ;; Setup tile row loop
        LDY #22
        -tileLoop:
        
            ;; Disable drawing
            LDA soft_ppu_mask
            AND #%11110111
            STA PPU_MASK
            
            ;; Set up scanline loop
            LDX #$08
            -scanlineLoop:
                CPX temp+8
                BNE +wasteTime
                
                ;; Restore drawing
                LDA soft_ppu_mask
                ORA #%00001000
                STA PPU_MASK
                JMP +wasteMoreTime

                ;; Waste 12 frames
                +wasteTime:
                INC temp+9   ;+5
                DEC temp+9   ;+5
                EOR #$00     ;+2
                
                ;; Waste about 100 frames
                +wasteMoreTime:
                
                STX temp+1     ;  3 down, 97 to go
                LDX #$09       ;  5 down, 95 to go
                -wasteLoop:
                    NOP
                    ORA #$FF   ;  5+3L down,  95-3L to go
                    DEX        ;  5+5L down,  95-5L to go
                BNE -wasteLoop ;  4+8L down,  96-8L to go

                LDX temp+1     ;  7+8L down, 93-8L to go
                DEX            ;  9+8L down, 91-8L to go
            BNE -scanlineLoop  ; 12+8L down, 88-8L to go

            DEY
        BNE -tileLoop

        LDY temp+8
        
        INC temp+7
        LDA temp+7
        CMP #$02
        BNE -fadeLoop

        LDA #$00
        STA temp+7
        DEY
    BNE -fadeLoop
    
    ;; Load the next level
    INC current_level
    LDA current_level
    CMP #25
    BNE +
        LDA #$00
        STA current_level
    +
    
    LDA #LOAD_GAME_SCREEN
    STA screen_mode


+end:
