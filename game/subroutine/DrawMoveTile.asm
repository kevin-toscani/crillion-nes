
;; Draw the move tile as follows:
;;
;;  1 2
;;  3 4 5
;;    6 7
;;
;; (1,2,3,4) is the move block itself
;; (5,6,7) are shades unless that tile is solid

;; X holds the move block sprite slot

sub_DrawMoveTile:

    ;; Get tile type index from sprite x and y values
    ;; and store it in a temp variable
    LDA move_block_x,x
    CLC
    ADC #MOVE_BLOCK_LEFT_WGA
    LSR
    LSR
    LSR
    LSR
    STA temp+9
    LDA move_block_y,x
    CLC
    ADC #MOVE_BLOCK_TOP_WGA
    AND #%11110000
    CLC
    ADC temp+9
    STA temp+9
    TAY
    
    ;; Add move tile data on the new tile location
    LDA move_block_tile_type,x
    STA tile_type,y

    ;; Draw the original tile type in the ppu buffer
    ;; - get PPU address to write to (temp, temp+1)
    TXA
    PHA
    LDX temp+9
    JSR sub_GetPPUAddrFromYXIndex
    PLA
    TAX
    
    ;; - based on color, select tile 42 or 4A for top left
    LDA move_block_flags,x
    LSR
    LSR
    LSR
    LSR
    LSR
    TAY
    LDA tbl_MoveBlockTopLeftTile,y
    STA temp+8
    
    ;; - save palette ID in temp+6
    TYA
    LSR
    STA temp+6
    
    ;; Prepare PPU buffer
    LDY ppu_buffer_pointer
    LDA #$00
    STA ppu_buffer_update
    
    ;; Draw tile 1 (top left tile of move block)
    JSR sub_DrawTileTemp018

    
    ;; Draw tile 2 (top right tile of move block)
    INC temp+1
    INC temp+8
    JSR sub_DrawTileTemp018

    ;; Draw tile 3 (bottom left tile of move block)
    LDA temp+1
    CLC
    ADC #$1F
    STA temp+1
    LDA temp
    ADC #$00
    STA temp
    LDA temp+8
    CLC
    ADC #$0F
    STA temp+8
    JSR sub_DrawTileTemp018

    ;; Draw tile 4 (bottom right tile of move block)
    INC temp+1
    INC temp+8
    JSR sub_DrawTileTemp018

    ;; Load tile type offset in X register
    TXA
    PHA
    LDX temp+9
    
    ;; Load shade tile in temp+8
    LDA #$00
    STA temp+8

    ;; Draw tile 5 (right shade) unless tile is solid
    INC temp+1
    
    TXA
    AND #%00001111
    CMP #$0D
    BEQ +nextTile

    LDA tile_type+1,x
    AND #%00000001
    BNE +nextTile
    
    JSR sub_DrawTileTemp018
    

+nextTile:
    ;; Draw tile 6 (bottom shade) unless tile is solid
    LDA temp+1
    CLC
    ADC #$1F
    STA temp+1
    LDA temp
    ADC #$00
    STA temp

    TXA
    AND #%11110000
    CMP #$90
    BEQ +nextTile

    LDA tile_type+16,x
    AND #%00000001
    BNE +nextTile
    
    JSR sub_DrawTileTemp018

    
+nextTile:
    ;; Draw tile 7 (bottom-right shade) unless tile is solid
    INC temp+1

    TXA
    AND #%11110000
    CMP #$90
    BEQ +setTileAttributes
    
    TXA
    AND #%00001111
    CMP #$0D
    BEQ +setTileAttributes
    
    LDA tile_type+17,x
    AND #%00000001
    BNE +setTileAttributes
    
    JSR sub_DrawTileTemp018
    

+setTileAttributes:
    ;; Update attribute table accordingly through ppu buffer
    ;; - PPU buffer high byte
    JSR sub_SetTileAttributeAddress

    TXA
    AND #%00010000
    BEQ +        
        LDA #%11110000
        JMP ++
    +
    LDA #%00001111
    ++
    STA temp+2
    
    TXA
    AND #%00000001
    BEQ +
        LDA temp+2
        ORA #%11001100
        JMP ++
    +
    LDA temp+2
    ORA #%00110011
    ++
    STA temp+2
    
    CMP #%11111100
    BEQ +continue
    
    CMP #%11110011
    BNE +
        LDA temp+6
        ASL
        ASL
        STA temp+6
        JMP +continue
    +
    
    CMP #%11001111
    BNE +
        LDX temp+6
        LDA tbl_Times16,x
        STA temp+6
        JMP +continue
    +
    
    LDX temp+6
    LDA tbl_Times64,x
    STA temp+6
        
+continue:
    LDA temp
    SEC
    SBC #$C0
    TAX
    LDA tile_attributes,x
    AND temp+2
    ORA temp+6
    STA tile_attributes,x
    STA ppu_buffer,y
    INY

    ;; Restore original X
    PLA
    TAX
    
    ;; Update PPU buffer
    STY ppu_buffer_pointer
    LDA #$01
    STA ppu_buffer_update

    ;; Return
    RTS

