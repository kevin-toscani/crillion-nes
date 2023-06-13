
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

    ;; Colors matchl destroy color block
    
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

