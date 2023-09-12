;;
;; Explosion sound effects
;;
;;   #% ffff vvvv
;;      |||| ++++---- volume (0=low, 15=high)
;;      ++++-------- frequency (0=low, 15=high)
;;
;; #$FF = end of sfx
;;

tbl_ExplosionSfx:
    .db #$00 ; buffer byte
    .db #$04, #$18, #$3C, #$2F, #$3F, #$2F, #$1F, #$1F
    .db #$0F, #$1F, #$1F, #$0F, #$0F, #$0F, #$1F, #$1F
    .db #$2F, #$1F, #$1F, #$2F, #$2F, #$1F, #$1F, #$0F
    .db #$0F, #$1F, #$0F, #$1F, #$1F, #$2F, #$0F, #$1E
    .db #$1D, #$0C, #$0B, #$0A, #$19, #$18, #$27, #$06
    .db #$15, #$14, #$03, #$02, #$01

tbl_ThudSfx:
    .db #$00 ; buffer byte doubles as end byte for explosion sfx
    .db #$6D, #$2F, #$9F, #$CF, #$DF, #$EF, #$ED, #$DB
    .db #$E8, #$C6, #$D4, #$E2, #$12

tbl_BounceSfx:
    .db #$00 ; buffer byte doubles as end byte for explosion sfx
    .db #$5F, #$46, #$42, #$12

    .db #$00

tbl_Sfx_hi:
    .db >#tbl_ExplosionSfx, >#tbl_ThudSfx, >#tbl_BounceSfx

tbl_Sfx_lo:
    .db <#tbl_ExplosionSfx, <#tbl_ThudSfx, <#tbl_BounceSfx


;; Volume envelope for move sound effect (reversed)
tbl_MoveSfxVolume:
    .db #$70, #$70, #$72, #$73, #$7B, #$7C, #$7B, #$7B
    .db #$79, #$79, #$78, #$77, #$76, #$76, #$75, #$75
    .db #$74, #$74, #$73, #$73, #$73, #$73, #$72, #$71

;; Volume and frequency table for paint sound effect (reversed)
tbl_PaintSfxVolume: .db #$00
    .db #$B0, #$B1, #$B2, #$B3, #$B2, #$B4, #$B6, #$B3
    .db #$B6, #$B9, #$B5, #$B9, #$B5, #$B9, #$B5, #$B9
tbl_PaintSfxFreqHi: .db #$00
    .db #$08, #$08, #$08, #$08, #$08, #$08, #$08, #$08
    .db #$08, #$09, #$08, #$09, #$09, #$09, #$09, #$09
tbl_PaintSfxFreqLo: .db #$00
    .db #$68, #$90, #$B8, #$E0, #$A4, #$CC, #$F4, #$BC
    .db #$E4, #$0C, #$F6, #$32, #$1A, #$56, #$44, #$80
    
;; End level sweep
tbl_SweepVolume:
    .db #$00, #$00, #$00, #$01, #$02, #$03, #$03, #$04
    .db #$05, #$07, #$08, #$09, #$09, #$0A, #$0B, #$0D
tbl_SweepFrequency:
    .db #$20, #$48, #$70, #$98, #$C0

;; End game sweep
tbl_EndSweepLength:
    .db #$02, #$02, #$03, #$03, #$04, #$04, #$05, #$05
    .db #$06, #$07, #$08, #$0A, #$0D, #$12, #$19, #$20
    .db #$24, #$26

tbl_EndSweepFreqDeltaLo:
    .db #$60, #$60, #$40, #$40, #$30, #$30, #$26, #$26
    .db #$20, #$1B, #$18, #$13, #$0E, #$0A, #$07, #$06
    .db #$05, #$05

tbl_EndSweepFreqDeltaRest:
    .db #$00, #$00, #$00, #$00, #$00, #$00, #$66, #$66
    .db #$00, #$6E, #$00, #$33, #$C5, #$AB, #$AE, #$00
    .db #$55, #$55
