
;; Remove a block from screen
sub_RemoveBlockFromScreen:

    ;; Get current buffer location
    LDY ppu_buffer_pointer
    
    ;; TILE 1: if metatile on top left is solid, draw
    ;; null tile, else draw random noise tile
    LDA #$00
    STA ppu_buffer_update
    
    LDA temp
    STA ppu_buffer,y
    INY
    LDA temp+1
    STA ppu_buffer,y
    INY
    
    TXA
    AND #%00001111
    BEQ +drawRandomTile

    TXA
    AND #%11110000
    BEQ +drawRandomTile

    LDA tile_type-17,x
    AND #%00000001
    BEQ +drawRandomTile  

    ;; Draw a null tile
    LDA #$00
    JMP +addToPPUBuffer
    
+drawRandomTile:
    ;; Draw a random tile
    JSR sub_GetRandomNumber
    AND #%00000111
    CLC
    ADC #$68
    
    ;; Add tile to ppu buffer
+addToPPUBuffer:
    STA ppu_buffer,y
    INY

    ;; TILE 2: If metatile above is solid, draw null,
    ;; else draw random noise.
    INC temp+1
    LDA temp
    STA ppu_buffer,y
    INY
    LDA temp+1
    STA ppu_buffer,y
    INY
    
    TXA
    AND #%11110000
    BEQ +drawRandomTile
    
    LDA tile_type-16,x
    AND #%00000001
    BEQ +drawRandomTile
    
    LDA #%00
    JMP +addToPPUBuffer

+drawRandomTile:
    JSR sub_GetRandomNumber
    AND #%00000111
    CLC
    ADC #$68

+addToPPUBuffer:
    STA ppu_buffer,y
    INY
    
    ;; TILE 3 - If metatile left is solid, draw null,
    ;; else draw random noise.
    LDA temp+1
    CLC
    ADC #$1F
    STA temp+1
    LDA temp
    ADC #$00
    STA temp
    STA ppu_buffer,y
    INY
    LDA temp+1
    STA ppu_buffer,y
    INY
    
    TXA
    AND #%00001111
    BEQ +drawRandomTile
    
    LDA tile_type-1,x
    AND #%00000001
    BEQ +drawRandomTile
    
    LDA #%00
    JMP +addToPPUBuffer

+drawRandomTile:
    JSR sub_GetRandomNumber
    AND #%00000111
    CLC
    ADC #$68
    
+addToPPUBuffer:
    STA ppu_buffer,y
    INY
    
    ;; TILE 4 - Always random noise
    INC temp+1
    LDA temp
    STA ppu_buffer,y
    INY
    LDA temp+1
    STA ppu_buffer,y
    INY
    JSR sub_GetRandomNumber
    AND #%00000111
    CLC
    ADC #$68
    STA ppu_buffer,y
    INY

    ;; TILE 5 - If tile on the right is solid, skip,
    ;; else draw random noise tile
    INC temp+1
    
    TXA
    AND #%00001111
    CMP #$0D
    BEQ +skipTile
    
    LDA tile_type+1,x
    AND #%00000001
    BNE +skipTile
        LDA temp
        STA ppu_buffer,y
        INY
        LDA temp+1
        STA ppu_buffer,y
        INY
        JSR sub_GetRandomNumber
        AND #%00000111
        CLC
        ADC #$68
        STA ppu_buffer,y
        INY    
    +skipTile:

    ;; TILE 6 - If tile on bottom is solid, skip,
    ;; else draw random noise
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
    BEQ +skipTile

    LDA tile_type+16,x
    AND #%00000001
    BNE +skipTile
        LDA temp
        STA ppu_buffer,y
        INY
        LDA temp+1
        STA ppu_buffer,y
        INY
        JSR sub_GetRandomNumber
        AND #%00000111
        CLC
        ADC #$68
        STA ppu_buffer,y
        INY    
    +skipTile:
    
    ;; TILE 7 - If tile on bottom right is solid, skip,
    ;; else draw random noise
    INC temp+1

    TXA
    AND #%11110000
    CMP #$90
    BEQ +skipTile
    
    TXA
    AND #%00001111
    CMP #$0D
    BEQ +skipTile
    
    LDA tile_type+17,x
    AND #%00000001
    BNE +skipTile
        LDA temp
        STA ppu_buffer,y
        INY
        LDA temp+1
        STA ppu_buffer,y
        INY
        JSR sub_GetRandomNumber
        AND #%00000111
        CLC
        ADC #$68
        STA ppu_buffer,y
        INY    
    +skipTile:   


    ;; Update attribute table accordingly through ppu buffer
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
    PHA
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
    
    LDA temp
    SEC
    SBC #$C0
    TAX
    LDA tile_attributes,x
    AND temp+2
    STA tile_attributes,x
    STA ppu_buffer,y
    INY
    PLA
    TAX

    ;; Tell PPU to update tiles and attributes next frame
    STY ppu_buffer_pointer
    LDA #$01
    STA ppu_buffer_update
 
    ;; We're done - return
    RTS

