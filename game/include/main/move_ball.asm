
    ;; Check if ball goes up or down
    LDA ball_flags
    AND #BALL_MOVES_DOWN
    BEQ +moveBallUp


+moveBallDown:
    ;; update the low byte
    LDA ball_ypos_lo
    STA ball_ypos_lo_prev
    CLC
    ADC #BALL_SPEED_LO
    STA ball_ypos_lo

    ;; update the high byte with carry
    LDA ball_ypos_hi
    STA ball_ypos_hi_prev
    ADC #BALL_SPEED_HI
    STA ball_ypos_hi
    
    ;; Check bottom bound
    CMP #BOUND_BOTTOM
    BCC +checkHorizontalMovement
    BEQ +checkHorizontalMovement


    ;; Change ball direction to "up"
    LDA #BOUND_BOTTOM
    SEC
    SBC #$01
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
    STA ball_ypos_lo_prev
    SEC
    SBC #BALL_SPEED_LO
    STA ball_ypos_lo

    ;; update the high byte with carry
    LDA ball_ypos_hi
    STA ball_ypos_hi_prev
    SBC #BALL_SPEED_HI
    STA ball_ypos_hi
    
    ;; Check top bound
    CMP #BOUND_TOP
    BCS +checkHorizontalMovement

    ;; Change ball direction to "down"
    LDA #BOUND_TOP
    CLC
    ADC #$01
    STA ball_ypos_hi
    LDA #$00
    STA ball_ypos_lo
    LDA ball_flags
    ORA #MOVE_BALL_DOWN
    STA ball_flags


+checkHorizontalMovement:

    ;; Check if ball is being nudged
    LDA nudge_timer
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
        
        ;; Set flag to nudge right and set nudge timer
        LDA ball_flags
        ORA #NUDGE_BALL_RIGHT
        JSR sub_InitiateNudge

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
        
        ;; Set flag to nudge left and set nudge timer
        LDA ball_flags
        AND #NUDGE_BALL_LEFT
        JSR sub_InitiateNudge
    +


+doneBallMovement:

    ;; Check nudge
    LDA nudge_timer
    BEQ +doneBallNudging
        LDA ball_flags
        AND #NUDGE_BALL_RIGHT
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
    ;; (moved to after move block routine)

+doneBallHandling:

