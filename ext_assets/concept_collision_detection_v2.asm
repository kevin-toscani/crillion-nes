;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CONCEPT: collision detection v2
;;
;;  Currently, the game checks for collision on the ball's
;;  edge centers. I'd like to experiment with checking the
;;  ball's corners instead, so top and bottom collision
;;  may be handled a bit better. Not sure how this will
;;  translate to gameplay, but it's worth the shot.
;;


;;
;;  Step 1: get the ball's bounding box corner values
;;

    LDA ball_xpos_hi
    CLC
    ADC #BALL_LEFT_BB_OFFSET
    STA ball_left

    CLC
    ADC #BALL_LEFT_BB_SIZE
    STA ball_right

    LDA ball_ypos_hi
    CLC
    ADC #BALL_LEFT_BB_OFFSET
    STA ball_top

    CLC
    ADC #BALL_LEFT_BB_SIZE
    STA ball_bottom


;;
;;  Step 2: check corners for collision
;;

+checkTopLeftCollision:
    ;; Check the ball's top left corner for collision
    LDA ball_top
    STA temp
    LDA ball_left
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkTopRightCollision

    ;; If moving left, nudge right; else bounce down
    LDA buttons_held
    AND #BUTTON_LEFT
    BEQ +
        JMP +nudgeRight
    +
    JMP +bounceDown

+checkTopRightCollision:
    ;; Check the ball's top right corner for collision
    LDA ball_right
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkBottomRightCollision

    ;; If moving right, nudge left; else bounce down
    LDA buttons_held
    AND #BUTTON_RIGHT
    BEQ +
        JMP +nudgeLeft
    +
    JMP +bounceDown

+checkBottomRightCollision:
    ;; Check the ball's bottom right corner for collision
    LDA ball_bottom
    STA temp
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkBottomLeftCollision

    ;; If moving right, nudge left; else bounce up
    LDA buttons_held
    AND #BUTTON_RIGHT
    BEQ +
        JMP +nudgeLeft
    +
    JMP +bounceUp

+checkBottomLeftCollision:
    ;; Check the ball's bottom left corner for collision
    LDA ball_left
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +doneCheckingCollision

    ;; If moving left, nudge right; else bounce up
    LDA buttons_held
    AND #BUTTON_LEFT
    BEQ +
        JMP +nudgeRight
    +
    ;JMP +bounceUp ; not needed as it's the next line


;;
;;  Step 3: modify ball movement based on collision
;;

+bounceUp:
    LDA ball_ypos_lo_prev
    STA ball_ypos_lo
    LDA ball_ypos_hi_prev
    STA ball_ypos_hi
    LDA ball_flags
    AND #MOVE_BALL_UP
    STA ball_flags

    LDA #$10
    STA move_block_space_to_check
    JMP +evaluateTileType

+bounceDown:
    LDA ball_ypos_lo_prev
    STA ball_ypos_lo
    LDA ball_ypos_hi_prev
    STA ball_ypos_hi
    LDA ball_flags
    ORA #MOVE_BALL_DOWN
    STA ball_flags

    LDA #$F0 ; which is -16
    STA move_block_space_to_check
    JMP +evaluateTileType

+nudgeLeft:
    LDA #$01
    STA move_block_space_to_check
    LDA ball_flags
    AND #NUDGE_BALL_LEFT
    JSR sub_InitiateNudge
    JMP +evaluateTileType

+nudgeRight:
    LDA #$FF
    STA move_block_space_to_check
    LDA ball_flags
    ORA #NUDGE_BALL_RIGHT
    JSR sub_InitiateNudge
    ;JMP +evaluateTileType ; not needed as it's the next line


;;
;;  Step 4: apply tile behaviour upon collision
;;

+evaluateTileType:
    JSR sub_EvaluateTileType

+doneCheckingCollision:
