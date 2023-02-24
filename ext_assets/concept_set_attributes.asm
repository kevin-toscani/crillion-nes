    ;; Byte 0-7 of attribute ram should be #%01010000
    LDX #$07
    LDA #$50
    -
        STA ADDR_ATTRIBUTERAM,x
        DEX
    BCC -

    ;; Byte 8-55 of attribute ram are filled with game subpal data
    ;; Use X for attribute index
    ;; Set up the loop
    LDX #$08

-attributeLoop:
    ;; Reset current attribute value
    LDA #$00
    STA temp+2

    ;; Get first metatile in tile ram based on attribute index
    ;; metatile = (attr-8)*2 -1 +(16*(attr-8)/8))
    TXA

    SEC
    SBC #$08
    STA temp+1      ; attr - 8 (temp1)
    ASL             ; * 2
    CLC
    ADC #$01        ; + 1
    STA temp        ; temp = temp1 * 2 + 1

    LDA temp+1      ; temp1
    AND #%11111000  ; rounded down to 8's
    ASL             ; * 2
    CLC
    ADC temp        ; + temp1 * 2 - 1
    STA temp        ; first metatile

    ;; Store first metatile in y-register
    TAY

    ;; If X MOD 8 == 0, don't apply bottom left metatile
    TXA
    AND #%00000111
    BEQ +

    ;; If X >= $30, don't apply bottom right metatile
    CPX #$30
    BCS +

    ;; Add metatile1 subpalette to attribute value
    LDA ADDR_SCREENTILERAM,y
    AND #%00001100
    STA temp+2
    +


    ;; Apply second metatile
    INY

    ;; If X MOD 8 == 7, don't apply bottom right metatile
    TXA
    AND #%00000111
    CMP #%00000111
    BEQ +

    ;; If X >= $30, don't apply bottom right metatile
    CPX #$30
    BCS +

    ;; Add metatile2 subpalette to attribute value
    LDA ADDR_SCREENTILERAM,y
    AND #%00001100
    LSR
    LSR
    ORA temp+2
    JMP ++
    +
    LDA temp+2
    ++
    ROL
    ROL
    STA temp+2


    ;; Apply third metatile
    TYA
    SEC
    SBC #$10
    TAY

    ;; If X MOD 8 == 7, don't apply bottom right metatile
    TXA
    AND #%00000111
    CMP #%00000111
    BEQ +

    ;; If X < 16, don't apply top right metatile
    TXA
    AND #%11110000
    BEQ +

    ;; Add metatile3 subpalette to attribute value
    LDA ADDR_SCREENTILERAM,y
    AND #%00001100
    LSR
    LSR
    ORA temp+2
    JMP ++
    +
    LDA temp+2
    ++
    ROL
    ROL
    STA temp+2


    ;; Apply fourth metatile
    INY

    ;; If X MOD 8 == 0, don't apply bottom left metatile
    TXA
    AND #%00000111
    BEQ +

    ;; If X < 16, don't apply top right metatile
    TXA
    AND #%11110000
    BEQ +

    ;; Add metatile3 subpalette to attribute value
    LDA ADDR_SCREENTILERAM,y
    AND #%00001100
    LSR
    LSR
    ORA temp+2
    JMP ++
    +
    LDA temp+2
    ++
    ROL
    ROL
    STA temp+2


    ;; Reset y-register
    LDY temp+3

    ;; Add two to the tile index
    INY
    INY

    ;; Add two more if we're at the end of a row;
    ;; in other words, if (Y MOD 16 == 14)
    TYA
    AND #%00001110
    CMP #%00001110
    BNE +
        INY
        INY
    +

    ;; Check the next attribute, if any left
    INX
    CPX #$38
    BNE -attributeLoop


    ;; Byte 56-63 of attribute ram can be whatever, since it's always
    ;; black either way, so we're done here