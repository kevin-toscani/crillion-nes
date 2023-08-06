
;; Draw a tile from the logo on the intro screen
sub_drawIntroScreenLogoTile:
    LDA tbl_IntroScreenLogoChr,y
    CMP #$60
    BNE +
        JSR sub_GetRandomNumber
        AND #$07
        CLC
        ADC #$60
    +
    STA PPU_DATA
    RTS

