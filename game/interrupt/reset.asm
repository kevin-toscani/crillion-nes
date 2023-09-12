
;; Softer reset
;; After game over, the game JMPs here to prevent
;; resetting the high score

lbl_SoftReset:

    ;; Check for cold or warm boot, by comparing
    ;; the 6-byte RAM and ROM sentience string.
    LDX #$00
    LDY #$00
    -
        LDA tbl_Sentient,x
        CMP sentience,x
        BEQ +
            INY
        +
        STA sentience,x
        INX
        CPX #$05
    BNE -

    ;; If system is sentient (warm boot), Y is zero now.
    CPY #$00
    BEQ +

        ;; System not sentient (cold boot)
        ;; Set default hi score to 100.000
        LDA #$01
        STA hi_score
        LDA #$00
        STA hi_score+1
        STA hi_score+2
        STA hi_score+3
        STA hi_score+4
        STA hi_score+5
    +

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
    LDA #START_LIVES
    STA ball_lives
    LDA #START_LEVEL
endif

    STA current_level

