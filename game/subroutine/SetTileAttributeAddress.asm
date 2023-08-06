
;; Set the correct tile attribute address based on game tile (x) 
;; into the correct ppu buffer slot (y)

sub_SetTileAttributeAddress:
    LDA #$23
    STA ppu_buffer,y
    INY
    
    TXA
    AND #%11110000
    LSR
    LSR
    LSR
    LSR
    CLC
    ADC #$01
    LSR
    ASL
    ASL
    ASL
    CLC
    ADC #$C8
    STA temp
    TXA
    AND #%00001111
    CLC
    ADC #$01
    LSR
    CLC
    ADC temp
    STA temp
    STA ppu_buffer,y
    INY
       
    RTS

