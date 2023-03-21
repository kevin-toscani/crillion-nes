    ;; If START button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BEQ +continue
        
        ;; Load the next level
        INC current_level
        LDA current_level
        CMP #25
        BNE +
            LDA #$00
            STA current_level
        +
        
        LDA #LOAD_GAME_SCREEN
        STA screen_mode

    +continue:
