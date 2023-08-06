
;; TEST SCRIPT: On pressing START, load the next level

    ;; If START button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BNE +
        JMP +end
    +

lbl_initiate_level_load:
    ;; Disable noise channel
    LDA #$00
    STA APU_STATUS
    STA NOISE_VOLUME
    
    JSR sub_BlindsEffect
    
    ;; Load the next level if ball not dead
    LDA ball_flags
    AND #BALL_IS_DEAD
    BNE +
        INC current_level
        JMP +loadLevel
    +
    
    ;; Revive ball
    LDA ball_flags
    AND #REVIVE_BALL
    STA ball_flags

+loadLevel:
    LDA current_level
    CMP #25
    BNE +
        LDA #$00
        STA current_level
    +
    
    LDA #LOAD_GAME_SCREEN
    STA screen_mode

+end:

