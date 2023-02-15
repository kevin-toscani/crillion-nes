;; game initialization goes here

    ;; Force NMI skip
	LDA #$01
	STA force_skip_nmi

    ;; Disable rendering
    LDA soft_ppu_mask
    AND #%11100111
    STA soft_ppu_mask
    JSR sub_WaitForVBlank

    ;; Load intro palette
    BIT PPU_STATUS
    LDA #$3F
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    LDX #$00
    -
        LDA tbl_IntroScreenPalette,x
        STA PPU_DATA
        INX
        CPX #$10
    BNE -

    ;; Set up intro screen draw loop
    LDX #$00

-loop_IntroScreenData:

    ;; Get current byte from intro screen data
    LDA tbl_IntroScreenData,x

    ;; If current byte is #$3F, we're done drawing.
    CMP #$3F
    BNE +
        JMP +goToEndIntroScreen
    +

    ;; If highest bits are %11, draw a plain tile
    AND #%11000000
    BNE +
        JMP +drawTile
    +
    
    ;; If highest bits are %01, set the PPU address
    ;; If not, draw two logo tiles
    CMP #%01000000
    BNE +drawLogo
        JMP +setPpuAddr

+drawLogo:
    ;; Get bits 0-2 and store in a temp variable
    LDA tbl_IntroScreenData,x
    AND #%00000111
    STA temp
    
    ;; Get bits 3-5, shift over to get a value from 0-7
    LDA tbl_IntroScreenData,x
    LSR
    LSR
    LSR
    AND #%00000111
    
    ;; Draw the tile that corresponds with that value
    TAY
    JSR sub_drawIntroScreenLogoTile
    
    ;; Do the same for the value stored in temp
    LDY temp
    JSR sub_drawIntroScreenLogoTile

    ;; Next byte please
    INX
    JMP -loop_IntroScreenData

+drawTile:
    ;; Just draw the tile value on screen
    LDA tbl_IntroScreenData,x
    STA PPU_DATA
    
    ;; Next byte please
    INX
    JMP -loop_IntroScreenData


+setPpuAddr:
    ;; Reset the PPU latch
    BIT PPU_STATUS
    
    ;; Sanitize and write the high byte of the PPU address
    LDA tbl_IntroScreenData,x
    AND #%00111111
    STA PPU_ADDR

    ;; Write the low byte of the PPU address
    INX
    LDA tbl_IntroScreenData,x
    STA PPU_ADDR
    
    ;; PPU has been set up to draw tiles at the correct spot now.
    
    ;; Next byte please.
    INX
    JMP -loop_IntroScreenData

+goToEndIntroScreen:

    ;; To color the 1.LEVEL: line green, we need to update two
    ;; values in the PPU attribute data.
    BIT PPU_STATUS
    LDA #$23
    STA PPU_ADDR
    LDA #$CB
    STA PPU_ADDR
    LDA #%00001010
    STA PPU_DATA
    STA PPU_DATA

    ;; Enable rendering
    LDA soft_ppu_mask
    ORA #%00011110
    STA soft_ppu_mask
	LDA #$00
	STA PPU_SCROLL
	STA PPU_SCROLL
	STA force_skip_nmi
    JSR sub_WaitForVBlank
