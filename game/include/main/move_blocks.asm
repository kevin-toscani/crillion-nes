
    ;; Set up block loop
    LDX #MAX_ANIMATIONS
-moveBlocksLoop:
    DEX

    ;; Check if block is still moving
    LDA move_block_timer,x
    BEQ +checkNext
    
    ;; Check if block is done moving
    CMP #$01
    BNE +
        ;; If so, draw a tile and remove the sprite
        JSR sub_DrawMoveTile
        LDA #$00
        STA move_block_timer,x
        JMP +checkNext
    +
    
    ;; Check in which direction the block is moving
    ;; 0 = down, 1 = up, 2 = right, 3 = left
    LDA move_block_flags,x
    AND #%00000011
    BEQ +movingDown
    CMP #$01
    BEQ +movingUp
    CMP #$02
    BEQ +movingRight
    
    ;; Move block in correct direction
    +movingLeft:
    DEC move_block_x,x
    JMP +checkNext

    +movingUp:
    DEC move_block_y,x
    JMP +checkNext

    +movingDown:
    INC move_block_y,x
    JMP +checkNext

    +movingRight:
    INC move_block_x,x

    ;; Check next block (if any left)
    +checkNext:
    CPX #$00
    BNE -moveBlocksLoop
    
    ;; Don't update sprites
    INC sprites_update_position

