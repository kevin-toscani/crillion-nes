
sub_SubtractXFromBonus:
    STX temp+9
    LDA ball_bonus+2
    SEC
    SBC temp+9
    BMI +
        STA ball_bonus+2
        JMP +updateBonusOnScreen
    +

    CLC
    ADC #$0A
    STA ball_bonus+2
    DEC ball_bonus+1
    BPL +updateBonusOnScreen

    LDA #$09
    STA ball_bonus+1
    DEC ball_bonus
    BPL +updateBonusOnScreen

    LDA #$00
    STA ball_bonus

    +updateBonusOnScreen:
    LDA #$20
    STA temp
    LDA #$9C
    STA temp+1
    LDX #$02
    
    -updateNextDigit:
        LDA ball_bonus,x
        CLC
        ADC #$01
        STA temp+2
        JSR sub_WriteByteToPPUBuffer
        DEC temp+1
        DEX
    BPL -updateNextDigit

    RTS

