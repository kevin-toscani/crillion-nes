
    ;; check if position should be updated (ie. has nmi happened yet)
    LDA ball_update_position
    BEQ +
        JMP +skipBallMovement
    +

    ;; Check if ball goes up or down
    LDA ball_flags
    AND #BALL_MOVES_DOWN
    BEQ +moveBallUp


+moveBallDown:
    ;; update the low byte
    LDA ball_ypos_lo
    CLC
    ADC #BALL_SPEED_LO
    STA ball_ypos_lo

    ;; update the high byte with carry
    LDA ball_ypos_hi
    ADC #BALL_SPEED_HI
    STA ball_ypos_hi
    
    ;; Check bottom bound
    CMP #BOUND_BOTTOM
    BCC +checkHorizontalMovement
    BEQ +checkHorizontalMovement

    ;; Update ball color (test)
    JSR sub_ColorizeBall

    ;; Change ball direction to "up"
    LDA #BOUND_BOTTOM
    STA ball_ypos_hi
    LDA #$00
    STA ball_ypos_lo
    LDA ball_flags
    AND #MOVE_BALL_UP
    STA ball_flags
    JMP +checkHorizontalMovement


+moveBallUp:
    ;; update the low byte
    LDA ball_ypos_lo
    SEC
    SBC #BALL_SPEED_LO
    STA ball_ypos_lo

    ;; update the high byte with carry
    LDA ball_ypos_hi
    SBC #BALL_SPEED_HI
    STA ball_ypos_hi
    
    ;; Check top bound
    CMP #BOUND_TOP
    BCS +checkHorizontalMovement

    ;; Change ball direction to "down"
    JSR sub_ColorizeBall
    LDA #BOUND_TOP
    STA ball_ypos_hi
    LDA #$00
    STA ball_ypos_lo
    LDA ball_flags
    ORA #MOVE_BALL_DOWN
    STA ball_flags


+checkHorizontalMovement:

    ;; Check if ball is being nudged
    LDA nudge_counter
    BNE +doneBallMovement

    ;; Check if left button is held
    LDA buttons_held
    AND #BUTTON_LEFT
    BEQ +
        ;; update the low byte
        LDA ball_xpos_lo
        SEC
        SBC #BALL_SPEED_LO
        STA ball_xpos_lo

        ;; update the high byte
        LDA ball_xpos_hi
        SBC #BALL_SPEED_HI
        STA ball_xpos_hi
        
        ;; Check left bound
        CMP #BOUND_LEFT
        BCS +doneBallMovement
        
        ;; Set flag to nudge right
        LDA ball_flags
        ORA #NUDGE_BALL_RIGHT
        STA ball_flags
        
        ;; Set nudge timer
        LDA #NUDGE_FRAMES
        STA nudge_counter
        

        JMP +doneBallMovement        
    +

    ;; Check if right button is held
    LDA buttons_held
    AND #BUTTON_RIGHT
    BEQ +
        ;; update the low byte
        LDA ball_xpos_lo
        CLC
        ADC #BALL_SPEED_LO
        STA ball_xpos_lo

        ;; update the high byte
        LDA ball_xpos_hi
        ADC #BALL_SPEED_HI
        STA ball_xpos_hi     

       ;; Check right bound
        CMP #BOUND_RIGHT
        BCC +doneBallMovement
        BEQ +doneBallMovement
        
        ;; Set flag to nudge right
        LDA ball_flags
        AND #NUDGE_BALL_LEFT
        STA ball_flags
        
        ;; Set nudge timer
        LDA #NUDGE_FRAMES
        STA nudge_counter
    +


+doneBallMovement:

    ;; Check nudge
    LDA nudge_counter
    BEQ +doneBallNudging
        LDA ball_flags
        AND NUDGE_BALL_RIGHT
        BEQ +nudgeBallLeft
        
            ;; update the low byte
            LDA ball_xpos_lo
            CLC
            ADC #BALL_SPEED_LO
            STA ball_xpos_lo

            ;; update the high byte
            LDA ball_xpos_hi
            ADC #BALL_SPEED_HI
            STA ball_xpos_hi  
            JMP +doneBallNudging
        +nudgeBallLeft:
        
        ;; update the low byte
        LDA ball_xpos_lo
        SEC
        SBC #BALL_SPEED_LO
        STA ball_xpos_lo

        ;; update the high byte
        LDA ball_xpos_hi
        SBC #BALL_SPEED_HI
        STA ball_xpos_hi
    +doneBallNudging:

    ;; Don't update position again until next frame
    INC ball_update_position



+skipBallMovement:
    ;; Add to sprite buffer
    LDX sprite_ram_pointer
    LDA ball_ypos_hi
    STA ADDR_SPRITERAM,x
    INX
    LDA #BALL_TILE_CHR
    STA ADDR_SPRITERAM,x
    INX
    LDA #BALL_ATTR
    STA ADDR_SPRITERAM,x
    INX
    LDA ball_xpos_hi
    STA ADDR_SPRITERAM,x
    INX
    STX sprite_ram_pointer

