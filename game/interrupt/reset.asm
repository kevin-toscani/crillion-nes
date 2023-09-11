
;; Softer reset
;; After game over, the game JMPs here to prevent
;; resetting the high score

lbl_SoftReset:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  NES TV system detection code
;;  Copyright 2011 Damian Yerrick
;;  https://www.nesdev.org/wiki/Detect_TV_system
;;
    LDX #$00
    LDY #$00
    LDA #$01
    STA check_nmi
    -
        CMP check_nmi
    BEQ -
    LDA #$01
    STA check_nmi
    -
        INX
        BNE +
            INY
        + CMP check_nmi
    BEQ -
    TYA
    SEC
    SBC #$0A
    CMP #$03
    BCC +
        LDA #$03
    + STA tv_system ; 0=ntsc, 1=pal, 2=dendy, 3=unknown
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    ;; Tell game to load the intro screen
    LDA #LOAD_INTRO_SCREEN
    STA screen_mode

    ;; Set number of lives (5)
    LDA #$05
    STA ball_lives

    ;; Start at level 1
    LDA #$00
    STA ball_score
    STA ball_score+1
    STA ball_score+2
    STA ball_score+3
    STA ball_score+4
    STA ball_score+5

ifdef TESTING
    LDA #$FF
    STA ball_lives
    LDA #TESTING
endif

    STA current_level

