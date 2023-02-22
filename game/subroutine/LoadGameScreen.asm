sub_LoadGameScreen:

    ;; Clear the screen
    JSR sub_ClearScreen
    
    ;; Get pointer from current level
    LDX current_level
    LDA tbl_lvl_layout_lo,x
    STA pointer
    LDA tbl_lvl_layout_hi,x
    STA pointer+1

    ;; Set up the loop
    LDY #$00
-drawRowColumnLoop:

    ;; Load (x,y) of current set of tiles
    LDA (pointer),y

    ;; Check if level is done; if so, skip the loop
    CMP #LEVEL_END
    BNE +
        JMP +doneLevelLoad
    +

    ;; Store (x,y) and number of tiles and tile data in temp variable
    STA temp
    INY
    LDA (pointer),y
    STA temp+1
    
    ;; Convert (x,y) to PPU address
    ;; temp+2 = PPU_hi = $20 + _y/4_ + carry from temp+3
    LDA temp
    AND #%00001111
    LSR
    LSR
    ORA #$20
    STA temp+2
    
    ;; temp+3 = PPU_lo = 2*x + $40*(y%4) + $C2
    LDA temp
    AND #%11110000
    LSR
    LSR
    LSR
    STA temp+3
    
    LDA temp
    AND #%00000011
    TAX
    LDA tbl_times64,x
    CLC
    ADC temp+3
    CLC
    ADC #$C2
    STA temp+3
    
    ;; Add carry to temp+2
    LDA temp+2
    ADC #$00
    STA temp+2

    ;; Convert tile data to loop count and tile type
    ;; temp+4 = color
    LDA temp+1
    AND #%00000111
    
    ;; If color = 7, this is a wall
    CMP #%00000111
    BEQ +wallHack
        STA temp+4
        
        ;; temp+7 = first or second set in CHR (add 5 to offset)
        AND #%00000001
        BEQ +
            LDA #$05
        +
        STA temp+7
     
        ;; temp+5 = tile type
        LDA temp+1
        LSR
        LSR
        LSR
        AND #%00000011
        JMP +setTileType
    +wallHack:
    
    ;; It's a wall! Set color and CHR offset to 0, and tile type to 4.
    LDA #$00
    STA temp+4
    STA temp+7
    LDA #$04

+setTileType:    
    STA temp+5
    
    ;; X = tile offset
    CLC
    ADC temp+7
    TAX
    
    ;; temp+6 = number of tiles
    LDA temp+1
    AND #%01100000
    LSR
    LSR
    LSR
    LSR
    LSR
    STA temp+6
    
    ;; Set up loop
    TYA
    PHA
    LDY temp+6

    -drawTileLoop:
        ;; Write PPU address
        BIT PPU_STATUS
        LDA temp+2
        STA PPU_ADDR
        LDA temp+3
        STA PPU_ADDR
        
        ;; Write first and second tile
        LDA tbl_gametile_top_left,x
        STA PPU_DATA
        LDA tbl_gametile_top_right,x
        STA PPU_DATA
        
        ;; Update PPU address
        BIT PPU_STATUS
        LDA temp+2
        STA PPU_ADDR
        LDA temp+3
        ADC #$20
        STA PPU_ADDR
        
        ;; Write third and fourth tile
        LDA tbl_gametile_bottom_left,x
        STA PPU_DATA
        LDA tbl_gametile_bottom_right,x
        STA PPU_DATA
        
        ;;
        ;; @TODO: draw shades
        ;; @TODO: implement collision table
        ;;
        
        ;; Draw next metatile in this loop (if any left)
        DEY
        BMI +doneDrawingRowColumn
        
        ;; Is it a row or a column?
        LDA temp+1
        BPL +
            ;; It is a column: move pointer down (+$40)
            LDA temp+3
            CLC
            ADC #$40
            STA temp+3
            LDA temp+2
            ADC #$00
            STA temp+2
            JMP +drawNextTile
        +
        
        ;; It is a column: move pointer right (+$02)
        LDA temp+3
        CLC
        ADC #$02
        STA temp+3
        
    
    ;; Next tile in the row/column
        +drawNextTile:
    JMP -drawTileLoop

    ;; Go to the next set of tiles
+doneDrawingRowColumn:
    PLA
    TAY
    INY
    JMP -drawRowColumnLoop

;; Level loading is done
+doneLevelLoad:

    ;; Top game bound: set PPU_ADDR offset and draw 28 tiles
    LDA #$20
    STA PPU_ADDR
    LDA #$A2
    STA PPU_ADDR
    LDA #$35
    JSR sub_Draw28HorizontalTiles

    ;; Bottom game bound: set PPU_ADDR offset and draw 28 tiles
    LDA #$23
    STA PPU_ADDR
    LDA #$42
    STA PPU_ADDR
    LDA #$31
    JSR sub_Draw28HorizontalTiles

    ;; Left & right game bounds
    ;; Set PPU_ADDR and store in temp variables
    LDA #$20
    STA temp
    STA PPU_ADDR
    LDA #$C1
    STA temp+1
    STA PPU_ADDR
    
    ;; Set vertical bound tile and set up loop
    LDY #$33
    LDX #20
    -
        ;; Show left tile
        STY PPU_DATA
        
        ;; Set PPU_ADDR to right bound by adding 29 (tiles) to low byte
        LDA temp
        STA PPU_ADDR
        LDA temp+1
        CLC
        ADC #29
        STA temp+1
        STA PPU_ADDR

        ;; Show right tile
        STY PPU_DATA

        ;; Check if we're done yet
        DEX
        BEQ +drawCorners
        
        ;; Not done yet: add 3 to low byte for next left bound
        LDA temp+1
        CLC
        ADC #3
        STA temp+1
        
        ;; Apply carry to high byte
        LDA temp
        ADC #$00
        STA temp
        
        ;; Store next PPU_ADDR to draw at
        STA PPU_ADDR
        LDA temp+1
        STA PPU_ADDR
    JMP -
    
+drawCorners:
    LDA #$20
    STA PPU_ADDR
    LDA #$A1
    STA PPU_ADDR
    LDA #$39
    STA PPU_DATA

    LDA #$20
    STA PPU_ADDR
    LDA #$BE
    STA PPU_ADDR
    LDA #$3A
    STA PPU_DATA

    LDA #$23
    STA PPU_ADDR
    LDA #$41
    STA PPU_ADDR
    LDA #$36
    STA PPU_DATA

    LDA #$23
    STA PPU_ADDR
    LDA #$5E
    STA PPU_ADDR
    LDA #$34
    STA PPU_DATA



    ;;
    ;; @TODO: draw hud
    ;;
    
    ;; Return
    RTS


;; Subroutine: draw 28 tiles in a row
sub_Draw28HorizontalTiles:
    LDX #28
    -
        STA PPU_DATA
        DEX
    BNE -
    RTS