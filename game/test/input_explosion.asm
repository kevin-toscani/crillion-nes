    LDA buttons_pressed
    AND #BUTTON_SELECT
    BEQ +
        LDA #$01
        STA explosion_sfx_timer
    +
