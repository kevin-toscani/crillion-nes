;; game initialization goes here

    ;; Tell game to load the intro screen
    LDA #LOAD_INTRO_SCREEN
    STA screen_mode

    ;; Set number of lives (5)
    LDA #$05
    STA ball_lives

    ;; Start at level -1 for now, because [START] increments level number
    LDA #$FF
    STA current_level