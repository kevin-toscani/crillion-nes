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
