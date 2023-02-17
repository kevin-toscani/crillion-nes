;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Conept: sprite movement
;;
;;  Move the y-position of the ball down 1,5 pixels per frame.
;;
;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In constants:

;; Add ball constants (speed high/low byte, tile and attribute)
;; Values are perceived; adjust upon implementation
BALL_SPEED_HI = #$01
BALL_SPEED_LO = #$80
BALL_TILE_CHR = #$01
BALL_ATTR     = #%01000000



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; in ZP RAM:

;; Set ball x and y position as zp variables
ball_xpos_hi  .dsb 1
ball_xpos_lo  .dsb 1
ball_ypos_hi  .dsb 1
ball_ypos_lo  .dsb 1

;; Set update-position check as zp variable
ball_update_position   .dsb 1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In main game loop:

    ;; check if position should be updated (ie. has nmi happened yet)
    LDA ball_update_position
    BNE +
        ;; update the high byte (backup in temp for easy
        ;; recover if ball should bounce back)
        LDA ball_ypos_hi
        STA temp
        CLC
        ADC #BALL_SPEED_HI
        STA ball_ypos_hi

        ;; update the low byte (backup in temp+1 for easy
        ;; recover if ball should bounce back)
        LDA ball_ypos_lo
        STA temp+1
        CLC
        ADC #BALL_SPEED_LO
        STA ball_ypos_lo

        ;; update overflow in high byte
        LDA ball_ypos_hi
        ADC #$00
        STA ball_ypos_hi

        ;; @TODO: check for and apply collision

        ;; Don't update position again until next frame
        INC ball_update_position
    +

    ;; Add to sprite buffer
    LDX sprite_ram_pointer
    STA SPRITE_RAM,x
    INX
    LDA #BALL_TILE_CHR
    STA SPRITE_RAM,x
    INX
    LDA #BALL_ATTR
    STA SPRITE_RAM,x
    INX
    LDA ball_xpos_hi
    STA SPRITE_RAM,x
    INX
    STX sprite_ram_pointer



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In NMI:

    ;; reset ball_update_position
    LDA #$00
    STA ball_update_position

