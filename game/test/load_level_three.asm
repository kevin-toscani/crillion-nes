    ;; If START button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BEQ +
        ;; Load level 3 for testing purposes
        LDA #$02
        STA current_level
        LDA #LOAD_GAME_SCREEN
        STA screen_mode
    +
