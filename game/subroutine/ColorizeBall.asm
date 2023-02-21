sub_ColorizeBall:

    ;; Get next ball color in cycle
    LDA ball_flags
    LSR
    LSR
    LSR
    LSR
    LSR
    CMP #$05
    BNE +
        LDA #$FF
    +
    CLC
    ADC #$01
    TAX

    ;; Update color in ball flags
    ASL
    ASL
    ASL
    ASL
    ASL
    STA temp
    LDA ball_flags
    AND #%00011111
    ORA temp
    STA ball_flags

    ;; Add new light color of ball to PPU palette
    LDA #$3F
    STA temp
    LDA #$11
    STA temp+1
    LDA tbl_BallColorLight,x
    STA temp+2
    JSR sub_WriteByteToPPUBuffer
    
    ;; Add new dark color of ball to PPU palette
    INC temp+1
    LDA tbl_BallColorDark,x
    STA temp+2
    JSR sub_WriteByteToPPUBuffer
    
    RTS