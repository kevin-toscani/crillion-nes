
;; Subroutine to clear the screen
;; If it's a game screen, add noise

sub_ClearScreen:
    ;; Check of game screen or not
    LDA screen_mode
    AND #CHECK_SCREEN_MODE
    CMP #IS_GAME_SCREEN
    BEQ +
        LDA #$00
    +
    STA temp+1
    
    ;; Set start writing address at tile (0,0) - or PPU address $2000
    BIT PPU_STATUS
    LDA #$20
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    
    ;; Set up tile to draw and loop
    STA temp
    TAX
    TAY

    -     
        ;; Write empty tile or noise (#$00) and add one to PPU address
        LDA temp
        STA PPU_DATA

        ;; Check if we should draw noise next. Noise is drawn if:
        ;; - Screen mode is game screen
        ;; - Y between #$06 and #$19 (inclusive)
        ;; - X between #$02 and #$1D (inclusive)
        
        ;; If not a game screen, or Y exceeds row $17, skip further check
        LDA temp+1
        BEQ +nextTileInRow
        
        ;; If Y < $6, skip the check
        CPY #$06
        BCC +nextTileInRow
        
        ;; If X < $1, skip the check
        CPX #$01
        BCC +nextTileInRow
        
        ;; If X >= $1D, skip the check. If it IS $1D, set temp = 0
        CPX #$1D
        BNE +
            LDA #$00
            STA temp
        +
        BCS +nextTileInRow
        
        ;; Load a random noise tile (tiles $68-$6F in CHR ROM)
        JSR sub_GetRandomNumber
        AND #%00000111
        CLC
        ADC #$68
        STA temp

+nextTileInRow:
        
        ;; Check if a row has been done. If not, draw the next
        INX
        CPX #$20
        BNE -
        
        ;; Go to the next row (if any left)
        LDX #00
        INY
        
        ;; If Y is 1A, skip noise tile check until done drawing
        CPY #$1A
        BNE +
            LDA #$00
            STA temp+1
        +
        
        CPY #$1E
    BNE -

    ;; Clear attribute table
    LDA #$23
    STA PPU_ADDR
    LDA #$C0
    STA PPU_ADDR
    LDA #$00
    LDX #$40
    -
        STA PPU_DATA
        DEX
    BNE -
    
    RTS

