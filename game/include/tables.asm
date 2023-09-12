
;; Initial screen palette
tbl_IntroScreenPalette:
    .db #$0F, #$2C, #$12, #$30
    .db #$0F, #$16, #$38, #$30
    .db #$0F, #$29, #$14, #$30
    .db #$0F, #$0F, #$10, #$30

    .db #$0F, #$2C, #$12, #$30
    .db #$0F, #$16, #$38, #$30
    .db #$0F, #$0F, #$14, #$30
    .db #$0F, #$00, #$10, #$30


;; Intro: mapping logo index to chr tile
tbl_IntroScreenLogoChr:
    .db #$00, #$31, #$33, #$60, #$30, #$32, #$34, #$36


;; Intro screen data
tbl_IntroScreenData:

    ;; Set PPU address $20A3 and draw
    .db #$60, #$A3
    .db #_1, #_DOT, #_L, #_E, #_V, #_E, #_L, #_COLON

    ;; Set PPU address $20C6 and draw
    .db #$60, #$C6
    .db #_0, #_1    

    ;; Set PPU address $20B4 and draw
    .db #$60, #$B4
    .db #_H, #_I, #_SPACE, #_S, #_C, #_O, #_R, #_E, #_COLON

    ;; Set PPU address $20D6 and draw high score
    .db #$60, #$D6, #$3E

    
    ;; Set PPU address $2122 and draw
    .db #$61, #$22
    .db #_D, #_E, #_S, #_I, #_G, #_N, #_COMMA
    .db #_S, #_O, #_U, #_N, #_D, #_COMMA
    .db #_G, #_R, #_A, #_P, #_H, #_I, #_C, #_S
    .db #_SPACE, #_A, #_N, #_D, #_SPACE
    
    ;; Set PPU address $2147 and draw
    .db #$61, #$47
    .db #_P, #_R, #_O, #_G, #_R, #_A, #_M
    .db #_SPACE, #_B, #_Y, #_SPACE
    .db #_O, #_L, #_I, #_V, #_E, #_R
    .db #_SPACE, #_K, #_I, #_R, #_W, #_A
    
    ;; Set PPU address $218B and draw
    .db #$61, #$8B
    .db #_COPY, #_SPACE, #_1, #_9, #_8, #_7
    .db #_COMMA, #_1, #_9, #_8, #_8
    
    ;; Set PPU address $21E6 and draw
    .db #$61, #$E6
    .db #_N, #_E, #_S, #_SPACE, #_P, #_O, #_R, #_T
    .db #_SPACE, #_B, #_Y, #_SPACE
    .db #_K, #_E, #_V, #_I, #_N, #_8, #_1
    
    ;; Set PPU address $222D and draw
    .db #$62, #$2D
    .db #_COPY, #_SPACE, #_2, #_0, #_2, #_3
    
    ;; Set PPU address $2281
    .db #$62, #$81
    
    ;; Draw the Crillion logo
    .db #%11100001, #%11001000, #%11100001, #%11101000
    .db #%11000010, #%11000010, #%11000000, #%11000010
    .db #%11000000, #%11000010, #%11000100, #%11001001
    .db #%11101000, #%11100001, #%11001101, #%11000000
    
    .db #%11010000, #%11000000, #%11010011, #%11010000
    .db #%11000010, #%11000010, #%11000000, #%11000010
    .db #%11000000, #%11000010, #%11000010, #%11011011
    .db #%11010000, #%11010000, #%11000010, #%11000000
    
    .db #%11010000, #%11000000, #%11010001, #%11001101
    .db #%11000010, #%11000010, #%11000000, #%11000010
    .db #%11000000, #%11000010, #%11000010, #%11011011
    .db #%11010000, #%11010000, #%11000010, #%11000000

    .db #%11010000, #%11000000, #%11010000, #%11000010
    .db #%11000010, #%11000010, #%11000000, #%11000010
    .db #%11000000, #%11000010, #%11000010, #%11011011
    .db #%11010000, #%11010000, #%11000010, #%11000000
    
    .db #%11010000, #%11000000, #%11010000, #%11000010
    .db #%11000010, #%11000010, #%11000000, #%11000010
    .db #%11000000, #%11000010, #%11000010, #%11011011
    .db #%11010000, #%11010000, #%11000010, #%11000000

    .db #%11111001, #%11001000, #%11010000, #%11000010
    .db #%11000010, #%11000111, #%11001001, #%11000111
    .db #%11001001, #%11000010, #%11000111, #%11001001
    .db #%11110000, #%11010000, #%11000010

    ;; End of intro
    .db #$3F


;; Animation frames table
.include "game/include/table/animation_frames.asm"


;; Ball palette color table (CBRYGM)
tbl_BallColorDark:
    .db #$2C, #$12, #$16, #$38, #$29, #$14
 
tbl_BallColorLight:
    .db #$3C, #$22, #$25, #$20, #$39, #$24

    
;; Screen mode drawing routine addresses
tbl_LoadScreenHi:
    .db >#sub_LoadIntroScreen, >#sub_LoadGameScreen, >#sub_LoadWinScreen

tbl_LoadScreenLo:
    .db <#sub_LoadIntroScreen, <#sub_LoadGameScreen, <#sub_LoadWinScreen


;; Level data
.include "game/include/table/level_data.asm"


;; Helper table to multiply values by 16
tbl_Times16:
    .db #$00, #$10, #$20, #$30, #$40, #$50, #$60, #$70
    .db #$80, #$90, #$A0, #$B0, #$C0, #$D0, #$E0, #$F0
    

;; Helper table to multiply values by 64
tbl_Times64:
    .db #$00, #$40, #$80, #$C0


;; Metatile ID to CHR data mapper
tbl_GametileTopLeft:
    .db #$40, #$42, #$46, #$44, #$38, #$48, #$4A, #$4E, #$4C, #$38

tbl_GametileTopRight:
    .db #$41, #$43, #$47, #$45, #$38, #$49, #$4B, #$4F, #$4D, #$38

tbl_GametileBottomLeft:
    .db #$50, #$52, #$56, #$54, #$38, #$58, #$5A, #$5E, #$5C, #$38

tbl_GametileBottomRight:
    .db #$51, #$53, #$57, #$55, #$38, #$59, #$5B, #$5F, #$5D, #$38

;; Metatile ID to RAM byte data mapper
tbl_GameTileRamByte:
    .db #%01000000, #%00100000, #%00010000, #%00001000, #%00000000

;; HUD text data (with opaque background tile for sprite zero)
tbl_HudText:
    .db #_S, #_C, #_O, #_R, #_E, #_SPACE, #_SPACE, #_SPACE
    .db #_L, #_E, #_V, #_E, #_L, #_SPACE, #_SPACE
    .db #_L, #_I, #_V, #_E, #_S, #_SPACE, #_SPACE, #_SPACE
    .db #_B, #_O, #_N, #_U, #_S, #_SPACE, #$3F

;; Move block top left tile based on color
tbl_MoveBlockTopLeftTile:
    .db #$42, #$4A, #$42, #$4A, #$42, #$4A, #$42

;; Game over data
tbl_GameOver:
    .db #_G, #_A, #_M, #_E
    .db #_SPACE, #_SPACE
    .db #_O, #_V, #_E, #_R

;; Background fade pallette table
tbl_BackgroundFade:
    .db #$00, #$10, #$20, #$30, #$30, #$30, #$20, #$10, #$00, #$0F

;; Sound effects
.include "game/include/table/sfx.asm"

;; Lookup table to convert bonus ticks to score
tbl_BonusToScore:
    .db #00, #10, #20, #30, #40, #50, #60, #70, #80, #90

;; Check string for sentience (warm boot)
tbl_Sentient: .db #$C0, #$FF, #$EE, #$54, #$07

tbl_EndGamePalette:
    .db #$0F, #$2D, #$00, #$3D
    .db #$3C, #$3B, #$38, #$37
    .db #$37, #$38, #$3B, #$3C
    .db #$3D, #$00, #$2D, #$0F