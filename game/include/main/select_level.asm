
    ;; Change level number on start screen
    LDA buttons_pressed
    AND #BUTTON_LEFT | #BUTTON_RIGHT
    BEQ +checkStartPress

        ;; Select next level (1, 5, 9, 13, 17)
        LDA current_level
        CLC
        ADC #$04
        CMP #$14
        BNE +
            LDA #$00
        +
        STA current_level
        
        ;; Convert level number to two-byte value
        LDA #$00
        STA temp+3
        LDA current_level
        CLC
        ADC #$01

    -
        CMP #$0A
        BCC +
            INC temp+3
            SEC
            SBC #$0A
            JMP -
        +

        ;; Add level number to PPU buffer
        CLC
        ADC #$01
        STA temp+2
        LDA #$20
        STA temp
        LDA #$C7
        STA temp+1
        JSR sub_WriteByteToPPUBuffer
        
        DEC temp+1
        LDY temp+3
        INY
        STY temp+2
        JSR sub_WriteByteToPPUBuffer
        
    +checkStartPress:



    ;; If START button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BEQ +
        ;; Start the level
        LDA #LOAD_GAME_SCREEN
        STA screen_mode
    +

