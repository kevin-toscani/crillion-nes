
    ;; Get ball's x-left, x-center, x-right position
    LDA ball_xpos_hi
    CLC
    ADC #BALL_LEFT_WGA
    STA ball_left
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_center
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_right

    ;; Get ball's y-top, y-middle, y-bottom position
    LDA ball_ypos_hi
    CLC
    ADC #BALL_TOP_WGA
    STA ball_top
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_middle
    CLC
    ADC #BALL_HALF_SIZE
    STA ball_bottom

+checkRightCollision:
    ;; Check if ball moves right
    ;; No need to check nudging here as that will never collide with a tile
    LDA buttons_held
    AND #BUTTON_RIGHT
    BEQ +checkLeftCollision

    ;; Check tile at right position
    LDA ball_middle
    STA temp
    LDA ball_right
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkTopCollision ; no need for left check as ball moves right

    ;; Nudge ball and evaluate tile type
    LDA #$01
    STA move_block_space_to_check
    LDA ball_flags
    AND #NUDGE_BALL_LEFT
    JSR sub_InitiateNudge
    JSR sub_EvaluateTileType
    JMP +checkTopCollision

+checkLeftCollision:
    ;; Check if ball moves right
    ;; No need to check nudging here as that will never collide with a tile
    LDA buttons_held
    AND #BUTTON_LEFT
    BEQ +checkTopCollision

    ;; Check tile at right position
    LDA ball_middle
    STA temp
    LDA ball_left
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +checkTopCollision

    ;; Tile is solid; nudge ball and evaluate tile type
    LDA #$FF
    STA move_block_space_to_check
    LDA ball_flags
    ORA #NUDGE_BALL_RIGHT
    JSR sub_InitiateNudge
    JSR sub_EvaluateTileType
    
    
+checkTopCollision:
    ;; Check if ball moves up
    LDA ball_flags
    AND #BALL_MOVES_DOWN
    BNE +checkBottomCollision

    ;; Check tile at top position
    LDA ball_top
    STA temp
    LDA ball_center
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +doneCheckingCollision ; no need for bottom check as ball moves up

    ;; Tile is solid; move ball down and evaluate tile type
    LDA ball_ypos_lo_prev
    STA ball_ypos_lo
    LDA ball_ypos_hi_prev
    STA ball_ypos_hi
    LDA ball_flags
    ORA #MOVE_BALL_DOWN
    STA ball_flags

    LDA #$F0 ; which is -16
    STA move_block_space_to_check
    JSR sub_EvaluateTileType
    JMP +doneCheckingCollision

+checkBottomCollision:
    ;; No movement check needed: since ball is not moving up, it must move down

    ;; Check tile at bottom position
    LDA ball_bottom
    STA temp
    LDA ball_center
    STA temp+1
    JSR sub_ConvertXYToTileType
    AND #TILE_IS_SOLID
    BEQ +doneCheckingCollision

    ;; Tile is solid; move ball up and evaluate tile type
    LDA ball_ypos_lo_prev
    STA ball_ypos_lo
    LDA ball_ypos_hi_prev
    STA ball_ypos_hi
    LDA ball_flags
    AND #MOVE_BALL_UP
    STA ball_flags

    LDA #$10
    STA move_block_space_to_check
    JSR sub_EvaluateTileType

+doneCheckingCollision:

