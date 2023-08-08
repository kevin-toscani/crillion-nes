
;; Softer reset
;; After game over, the game JMPs here to prevent
;; resetting the high score

lbl_SoftReset:

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
    LDA #15
endif

    STA current_level

