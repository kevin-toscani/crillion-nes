    ;; If START button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BNE +
        JMP +end
    +

    LDA #$21
    STA temp
    LDA #$E0
    STA temp+1
    LDA #$28
    STA temp+2
    JSR sub_WriteByteToPPUBuffer

+end: