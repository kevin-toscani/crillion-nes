sub_ClearScreen:
    BIT PPU_STATUS
    LDA #$20
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    TAX
    TAY
    -
        STA PPU_DATA
        INX
        BNE -
        INY
        CPY #$04
    BNE -
    RTS