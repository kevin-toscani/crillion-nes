    LDA buttons_pressed
    AND #BUTTON_SELECT
    BEQ +
        LDA #$01
        STA do_beeps
    +
    
    LDA buttons_released
    AND #BUTTON_SELECT
    BEQ +
        LDA #$02
        STA do_beeps
    +