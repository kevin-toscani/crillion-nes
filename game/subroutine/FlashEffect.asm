
;; Apply flashing light effect to background color
sub_FlashEffect:
    LDX #$00
    STX temp+1
    LDA #$3F
    STA temp

    -flashLoop:
        LDA tbl_BackgroundFade,x
        STA temp+2
        JSR sub_WriteByteToPPUBuffer
        LDA #$0D
        STA temp+1
        JSR sub_WriteByteToPPUBuffer
        LDA #$19
        STA temp+1
        JSR sub_WriteByteToPPUBuffer
        LDA #$00
        STA temp+1
        LDY #$03
        -
            JSR sub_WaitForNMI
            DEY
        BNE -
        INX
        CPX #$0A
    BNE -flashLoop
    
    RTS

