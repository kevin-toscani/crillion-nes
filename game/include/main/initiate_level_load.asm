
;; Load level
lbl_InitiateLevelLoad:
    
    ;; Blind out the screen
    JSR sub_BlindsEffect
    
    ;; If ball is dead, (re)load current level
    ;; If ball is alive, load next level
    LDA ball_flags
    AND #BALL_IS_DEAD
    BNE +
        INC current_level
        JMP +loadLevel
    +
    
    ;; Revive ball
    LDA ball_flags
    AND #REVIVE_BALL
    STA ball_flags

+loadLevel:
    ;; This loops back to level 1 after level 25 for now,
    ;; as a proper game ending is yet to be introduced.
    LDA current_level
    CMP #25
    BNE +
        LDA #$00
        STA current_level
    +
    
    ;; Tell the game to load the level screen on the next loop.
    LDA #LOAD_GAME_SCREEN
    STA screen_mode

    ;; Jump to the beginning of the loop, instantly starting screen drawing
    JMP lbl_MainGameLoop