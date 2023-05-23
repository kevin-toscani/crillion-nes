
;; Subroutine to evaluate the colliding tile type and take its
;; corresponding action (move block, kill player, ...)
;; - Expects X-register to be the tile_type offset
;; - Uses zp variable colliding_tile

sub_EvaluateTileType:

    ;; Check if collided tile is a color block
    LDA colliding_tile
    AND #IS_COLOR_BLOCK
    BNE +
        JMP +checkIfPaintBlock
    +
    
    ;; It's a color block. Check if the colors match
    JSR sub_ColorsMatch
    BEQ +
        ;; Colors don't match - return
        RTS
    +

    ;; Colors match. Destroy color block
    LDY ppu_buffer_pointer
    
    ;; (this will be a subroutine)
    ;; Get PPU address from YX index
    ;; PPU_lo = #$C2 +  2*x + $40*(y%4)     = temp+1
    ;; PPU_hi = (Y/4) + $20 + carry(PPU_lo) = temp
    TXA
    AND #%11000000
    CLC
    ROL
    ROL
    ROL
    ADC #$20
    STA temp
    TXA
    AND #%00001111
    ASL
    STA temp+1
    TXA
    AND #%00110000
    ASL
    ASL
    CLC
    ADC temp+1
    STA temp+1
    LDA temp
    ADC #$00
    STA temp
    LDA temp+1
    CLC
    ADC #$C2
    STA temp+1
    LDA temp
    ADC #$00
    STA temp

    
    ;; (this will also be a subroutine eventually)
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


    ;; - Update attribute table accordingly through ppu buffer
    LDA #$23
    STA ppu_buffer,y
    INY
    
    TXA
    AND #%11110000
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC #1
    LSR
    ASL
    ASL
    ASL
    CLC
    ADC #$C8
    STA temp
    TXA
    AND #%00001111
    CLC
    ADC #$01
    LSR
    CLC
    ADC temp
    STA temp
    STA ppu_buffer,y
    INY
       
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
 
    
    ;; - Load destruction animation on tile
    ;; Get most recent slot for explosion    
    TXA
    STA temp+2
    LDX explosion_pointer

    ;; If 0, use max pointer value
    BNE +
        LDX #MAX_ANIMATIONS
    +

    ;; Decrease pointer by one
    DEX
    STX explosion_pointer

    ;; Load explosion data into RAM
    LDA #$00
    STA explosion_currentframe,x

    LDA #ANIMATION_SPEED
    STA explosion_framecounter,x

    LDA temp+2
    AND #%00001111
    TAY
    LDA tbl_Times16,y
    CLC
    ADC #$0E
    STA explosion_x,x

    LDA temp+2
    AND #%11110000
    CLC
    ADC #$29
    STA explosion_y,x

    LDA #$03 ; subpalette 3 is for wall explosions
    STA explosion_attributes,x
    LDA #$01
    STA explosion_active,x

    LDA temp+2
    TAX
    
    
    ;; - Write #$00 in tile type ram (makes not-solid)
    LDA #$00
    STA tile_type, x


    ;; Add (80 + level number) to score
    LDA current_level
    CLC
    ADC #81
    JSR sub_AddAccumulatorToScore


    ;; - If there are no color blocks left:
    ;;   - Freeze ball
    ;;   - Initiate level-win state
    ;; [@TODO]
    
    RTS

+checkIfPaintBlock:


    ;; Check if collided tile is a paint block
    LDA colliding_tile
    AND #IS_PAINT_BLOCK
    BEQ +checkIfDeathBlock
        ;; It's a paint block. Update ball color
        ;; Save x-register
        TXA
        PHA

        ;; Get tile color
        LDA colliding_tile
        AND #%00001110
        ASL
        ASL
        ASL
        ASL
        STA temp

        ;; Apply tile color to ball
        LDA ball_flags
        AND #%00011111
        ORA temp
        STA ball_flags
        JSR sub_ColorizeBall

        ;; Restore x-register
        PLA
        TAX

        ;; Return
        RTS
    +checkIfDeathBlock:

    ;; Check if collided tile is a death block
    LDA colliding_tile
    AND #IS_DEATH_BLOCK
    BEQ +checkIfMoveBlock

        ;; It is a death block
        ;; Freeze and kill player
        LDA ball_flags
        ORA #%00000101
        STA ball_flags
        
        ;; Get free explosion slot
        LDX explosion_pointer
        BNE +
            LDX #MAX_ANIMATIONS
        +
        DEX
        STX explosion_pointer

        ;; Load explosion data into RAM
        LDA #$00
        STA explosion_currentframe,x

        LDA #ANIMATION_SPEED
        STA explosion_framecounter,x

        LDA ball_xpos_hi
        SEC
        SBC #$08
        STA explosion_x,x

        LDA ball_ypos_hi
        SEC
        SBC #$06
        STA explosion_y,x

        LDA #$01 ; subpalette 1 is for ball explosions
        STA explosion_attributes,x

        LDA #$01
        STA explosion_active,x

        ;; Set kill counter
        LDA #$60
        STA kill_counter

        ;; Return
        RTS


+checkIfMoveBlock:

    ;; Check if collided tile is a move block
    LDA colliding_tile
    AND #IS_MOVE_BLOCK
    BEQ +done
        ;; It is a move block. Check if colors match
        JSR sub_ColorsMatch
        BEQ +
            ;; Colors don't match - return
            RTS
        +

        ;; Colors match.
        ;; - Check if next tile is a solid
        ;; - If not, move the tile:
        ;;   - Add the tiles that need updating to ppu buffer
        ;;   - Add move tile sprite over the original tile
        ;;   - Initiate moving the sprite that way for 16px
        ;;   - Write #$00 in tile type ram (makes not-solid)
        ;;   - Update attribute table accordingly through ppu buffer
        ;; - After moving the sprite, in a different routine:
        ;;   - Add move tile data on the new tile location
        ;;   - Write the original tile type data on new position in ram
        ;;   - Destroy sprite
        ;;   - Update attribute table accordingly through ppu buffer
        ;; [@TODO]
        RTS
    +done:

    ;; Return
    RTS

