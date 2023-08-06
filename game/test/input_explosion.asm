
    ;; TEST SCRIPT: while pressing SELECT, play explosion sound effect
    LDA buttons_pressed
    AND #BUTTON_SELECT
    BEQ +
        LDA #$01
        STA explosion_sfx_timer
    +

