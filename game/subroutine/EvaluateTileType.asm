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

    ;; Colors match; destroy color block
    
    ;; Convert the metatile offset value (which is in the X register)
    ;; to its corresponding address in PPU
    JSR sub_GetPPUAddrFromYXIndex

    ;; Remove color block from screen by drawing a total
    ;; of 7 tiles over it (shade included)
    JSR sub_RemoveBlockFromScreen
    
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
    STA explosion_timer,x

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
    ;;   - Initiate level-win state [@TODO]
    DEC blocks_left
    BNE +
        LDA ball_flags
        ORA #FREEZE_BALL
        STA ball_flags
    +
    
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
        STA explosion_timer,x

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

        ;; Set kill timer
        LDA #$60
        STA kill_timer

        ;; Return
        RTS


+checkIfMoveBlock:

    ;; Check if collided tile is a move block
    LDA colliding_tile
    AND #IS_MOVE_BLOCK
    BNE +
        RTS
    +

    ;; It is a move block. Check if colors match
    JSR sub_ColorsMatch
    BEQ +
        RTS
    +

    ;; Colors match
    ;; - Check if next tile is within the playground
    ;; (push X onto stack as well)
    TXA
    PHA
    CLC
    ADC move_block_space_to_check
    TAX
    
    AND #%00001111
    CMP #$0E
    BCC +
        JMP +restoreX
    +
    TXA
    AND #%11110000
    CMP #$A0
    BNE +
        JMP +restoreX
    +
    CMP #$F0
    BNE +
        JMP +restoreX
    +
    
    ;; Check if the next tile is solid
    LDA tile_type,x
    AND #TILE_IS_SOLID
    BEQ +
        JMP +restoreX
    +
    
    ;; Move block has room to move
    ;; Pull original X from stack
    PLA
    TAX        
    
    ;; Add the tiles that need updating to ppu buffer, and
    ;; update attribute table accordingly through ppu buffer
    JSR sub_GetPPUAddrFromYXIndex
    JSR sub_RemoveBlockFromScreen

    ;; Write #$00 in tile type ram (makes not-solid)
    LDA #$00
    STA tile_type, x

    ;; Add move tile sprite over the original tile
    ;; - Store x in temp variable
    STX temp+3
    
    ;; - Update move block pointer
    LDX move_block_pointer
    BNE +
        LDX #MAX_ANIMATIONS
    +
    DEX
    STX move_block_pointer
    
    ;; - Set move block X position
    LDA temp+3
    AND #%00001111
    TAY
    INY
    LDA tbl_Times16,y
    STA move_block_x,x
    
    ;; - Set move block Y position
    LDA temp+3
    AND #%11110000
    CLC
    ADC #$30
    STA move_block_y,x
    DEC move_block_y,x
    
    ;; - Set timer to 16 frames
    LDA #$10
    STA move_block_timer,x
    
    ;; - Set move direction
    LDA move_block_space_to_check
    AND #%10000001
    CLC
    ROL
    ADC #$00
    STA temp+4
    
    ;; - Set block color as ball color and add direction
    LDA ball_flags
    AND #BALL_COLOR
    ORA temp+4
    STA move_block_flags,x
    
    ;; - Restore original X
    LDX temp+3
    

    ;; - In a different routine:
    ;;   - Add move tile data on the new tile location
    ;;   - Write the original tile type data on new position in ram
    ;;   - Destroy sprite
    ;;   - Update attribute table accordingly through ppu buffer
    ;; [@TODO]
        
        
    ;; Return
    RTS


;; Pull X register from stack before returning
+restoreX:
    PLA
    TAX
    RTS
