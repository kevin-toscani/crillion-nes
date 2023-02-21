
;; Intro screen palette
tbl_IntroScreenPalette:
    .db #$0F, #$2C, #$12, #$30
    .db #$0F, #$16, #$38, #$30
    .db #$0F, #$29, #$14, #$30
    .db #$0F, #$00, #$10, #$30

    .db #$0F, #$2C, #$12, #$30
    .db #$0F, #$16, #$38, #$30
    .db #$0F, #$29, #$14, #$30
    .db #$0F, #$00, #$10, #$30


;; Intro: mapping logo index to chr tile
tbl_IntroScreenLogoChr:
    .db #$00, #$31, #$33, #$60, #$30, #$32, #$34, #$36


;; Intro screen data
tbl_IntroScreenData:

    ;; Set PPU address $20AC
    .db #$60, #$AC
    
    ;; Draw
    .db #$02, #$26, #$16, #$0F, #$20, #$0F, #$16, #$27 ; 1.LEVEL:

    ;; Set PPU address $20CF
    .db #$60, #$CF
    
    ;; Draw
    .db #$01, #$02                                     ; 01
    
    ;; Set PPU address $2122
    .db #$61, #$22
    
    ;; Draw
    .db #$0E, #$0F, #$1D, #$13, #$11, #$18, #$25       ; DESIGN,
    .db #$1D, #$19, #$1F, #$18, #$0E, #$25             ; SOUND,
    .db #$11, #$1C, #$0B, #$1A, #$12, #$13, #$0D, #$1D ; GRAPHICS
    .db #$00, #$0B, #$18, #$0E, #$00                   ; _AND_
    
    ;; Set PPU address $2147
    .db #$61, #$47
    
    ;; Draw
    .db #$1A, #$1C, #$19, #$11, #$1C, #$0B, #$17       ; PROGRAM
    .db #$00, #$0C, #$23, #$00                         ; _BY_
    .db #$19, #$16, #$13, #$20, #$0F, #$1C             ; OLIVER
    .db #$00, #$15, #$13, #$1C, #$21, #$0B             ; _KIRWA
    
    ;; Set PPU address $218B
    .db #$61, #$8B
    
    ;; Draw
    .db #$28, #$00, #$02, #$0A, #$09, #$08             ; C_1987
    .db #$25, #$02, #$0A, #$09, #$09                   ; ,1988
    
    ;; Set PPU address $21E6
    .db #$61, #$E6
    
    ;; Draw
    .db #$18, #$0F, #$1D, #$00, #$1A, #$19, #$1C, #$1E ; NES_PORT
    .db #$00, #$0C, #$23, #$00                         ; _BY_
    .db #$15, #$0F, #$20, #$13, #$18, #$09, #$02       ; KEVIN81
    
    ;; Set PPU address $222D
    .db #$62, #$2D
    
    ;; Draw
    .db #$28, #$00, #$03, #$01, #$03, #$04             ; C_2023
    
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


;; test animation table
.include "game/test/show_animation_table.asm"


;; Ball palette color cycle
tbl_BallColorDark:
    .db #$12, #$14, #$16, #$27, #$28, #$19
 
tbl_BallColorLight:
    .db #$2C, #$24, #$25, #$37, #$20, #$2B

    
;; Screen mode drawing routine addresses
tbl_LoadScreenHi:
    .db >#sub_LoadIntroScreen, >#sub_LoadGameScreen, >#sub_LoadWinScreen

tbl_LoadScreenLo:
    .db <#sub_LoadIntroScreen, <#sub_LoadGameScreen, <#sub_LoadWinScreen


;; Test level data
.include "game/test/level_data.asm"


;; Helper table to multiply values by 64
tbl_times64:
    .db #$00, #$40, #$80, #$C0


;; Metatile ID to CHR data mapper
tbl_gametile_top_left:
    .db #$40, #$42, #$46, #$44, #$38, #$48, #$4A, #$4E, #$4C, #$38

tbl_gametile_top_right:
    .db #$41, #$43, #$47, #$45, #$38, #$49, #$4B, #$4F, #$4D, #$38

tbl_gametile_bottom_left:
    .db #$50, #$52, #$56, #$54, #$38, #$58, #$5A, #$5E, #$5C, #$38

tbl_gametile_bottom_right:
    .db #$51, #$53, #$57, #$55, #$38, #$59, #$5B, #$5F, #$5D, #$38