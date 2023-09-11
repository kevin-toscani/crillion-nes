
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
        ;; Colors don't match
        ;; Play bounce sound effect
        LDX #SFX_BOUNCE
        JSR sub_PreloadSfxFromX
        
        ;; Return
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


    ;; Play thud sound effect
    LDX #SFX_THUD
    JSR sub_PreloadSfxFromX


    ;; - If there are no color blocks left:
    ;;   - Initiate level-win state
    DEC blocks_left
    BNE +
        JMP lbl_LevelWin
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

        ;; Play paint sound effect
        LDA #$10
        STA sfx_timer+2

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

;; Also, when the player presses select during gameplay,
;; insta-selfdestruct the ball.
sub_Selfdestruct:

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

        LDA #$01
        STA explosion_attributes,x  ; set subpalette 1 for ball explosion
        STA explosion_active,x      ; set explosion animation to active
        STA noise_muted             ; mute background noise
        
        ;; Play explosion sound effect
        LDX #SFX_EXPLOSION
        JSR sub_PreloadSfxFromX

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
        ;; Tile is not a move block
        ;; Therefore, it is a solid wall
        
        ;; Play bounce sound effect
        LDX #SFX_BOUNCE
        JSR sub_PreloadSfxFromX

        ;; Return
        RTS
    +

    ;; It is a move block. Check if colors match
    JSR sub_ColorsMatch
    BEQ +
        ;; Colors do not match
        ;; Play bounce sound effect
        LDX #SFX_BOUNCE
        JSR sub_PreloadSfxFromX

        ;; Return
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
        JMP +dontMoveBlock
    +
    TXA
    AND #%11110000
    CMP #$A0
    BNE +
        JMP +dontMoveBlock
    +
    CMP #$F0
    BNE +
        JMP +dontMoveBlock
    +
    
    ;; Check if the next tile is solid
    LDA tile_type,x
    AND #TILE_IS_SOLID
    BEQ +
        JMP +dontMoveBlock
    +
    
    ;; Move block has room to move
    ;; Pull original X from stack
    PLA
    TAX        
    
    ;; Add the tiles that need updating to ppu buffer, and
    ;; update attribute table accordingly through ppu buffer
    JSR sub_GetPPUAddrFromYXIndex
    JSR sub_RemoveBlockFromScreen

    ;; Store original tile type in temp variable
    LDA tile_type,x
    STA temp+8

    ;; Write #$00 in tile type ram (makes not-solid)
    LDA #$00
    STA tile_type,x

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

    ;; = Set move block tile type
    LDA temp+8
    STA move_block_tile_type,x

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
    
    ;; - Set timer to 16 (+1) frames
    LDA #$11
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
    
    ;; - Initiate move sound effect
    LDA #$18
    STA sfx_timer+1

    ;; Return
    RTS


;; Do not move the move block
+dontMoveBlock:

    ;; Play bounce sound effect
    LDX #SFX_BOUNCE
    JSR sub_PreloadSfxFromX

    ;; Restore X from stack
    PLA
    TAX
    
    ;; Return
    RTS

