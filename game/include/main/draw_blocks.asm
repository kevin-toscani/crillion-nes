
;; Handle movement of move blocks

    ;; Set up a loop
    LDY #MAX_ANIMATIONS
-drawBlocksLoop:
    DEY

    ;; If timer is zero, check the next move block
    LDA move_block_timer,y
    BEQ +nextMoveBlock
    
    ;; Get current sprite pointer
    LDX sprite_ram_pointer

    ;; Draw the sprites on screen
    LDA move_block_y,y
    STA ADDR_SPRITERAM,x
    STA ADDR_SPRITERAM+4,x
    CLC
    ADC #$08
    STA ADDR_SPRITERAM+8,x
    STA ADDR_SPRITERAM+12,x
    INX

    LDA #$52 ; Top left chr id
    STA ADDR_SPRITERAM,x
    LDA #$53 ; Top right chr id
    STA ADDR_SPRITERAM+4,x
    LDA #$62 ; Bottom left chr id
    STA ADDR_SPRITERAM+8,x
    LDA #$63 ; Bottom right chr id
    STA ADDR_SPRITERAM+12,x
    INX

    LDA #BALL_ATTR
    STA ADDR_SPRITERAM,x
    STA ADDR_SPRITERAM+4,x
    STA ADDR_SPRITERAM+8,x
    STA ADDR_SPRITERAM+12,x
    INX

    LDA move_block_x,y
    STA ADDR_SPRITERAM,x
    STA ADDR_SPRITERAM+8,x
    CLC
    ADC #$08
    STA ADDR_SPRITERAM+4,x
    STA ADDR_SPRITERAM+12,x

    ;; Update sprite RAM pointer
    LDA sprite_ram_pointer
    CLC
    ADC #$10
    STA sprite_ram_pointer



+nextMoveBlock:
    ;; Check the next move block
    CPY #$00
    BNE -drawBlocksLoop

