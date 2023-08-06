
;; Get the PPU address from YX index
;; - Expects YX index (aka tile offset) to be in the X register
;; - Writes the 16-bit PPU address in temp (hi) and temp+1 (lo)

;; PPU_lo = #$C2 +  2*x + $40*(y%4)     = temp+1
;; PPU_hi = (Y/4) + $20 + carry(PPU_lo) = temp

sub_GetPPUAddrFromYXIndex:
    TXA
    AND #%11000000
    CLC
    ROL
    ROL
    ROL
    ADC #$20
    STA temp
    
    TXA
    AND #%00001111
    ASL
    STA temp+1
    
    TXA
    AND #%00110000
    ASL
    ASL
    CLC
    ADC temp+1
    STA temp+1
    
    LDA temp
    ADC #$00
    STA temp
    
    LDA temp+1
    CLC
    ADC #$C2
    STA temp+1
    
    LDA temp
    ADC #$00
    STA temp

    RTS

