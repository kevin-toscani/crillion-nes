
;; Do the blinds effect (i.e. wipe the screen line by line)
sub_BlindsEffect:

    ;; Set up loop fading
    LDA #$00
    STA temp+7
    LDY #$08
    -fadeLoop:
        STY temp+8

        ;; Wait for NMI to pass
        JSR sub_WaitForNMI
        
        ;; Now wait for No-sprite 0
        -
            LDA PPU_STATUS
        BVS -
    
        ;; Now wait for Sprite 0
        -
            LDA PPU_STATUS
        BVC -
        
        ;; Waste time until we're almost at the last HBlank before the playing field
        JSR sub_Waste6
        JSR sub_Waste5
        JSR sub_Waste4
        JSR sub_Waste3
        JSR sub_Waste1
        JSR sub_Waste0
        
        
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
                INC void     ;+5
                DEC void     ;+5
                EOR #$00     ;+2
                
                ;; Waste about a scanline worth of frames
                +wasteMoreTime:
                JSR sub_Waste2
                JSR sub_Waste0
                JSR sub_Waste0
                INC void
                EOR #$00
                EOR #$00
                DEX
            BNE -scanlineLoop
            DEC void
            EOR #$00
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
    
    RTS

