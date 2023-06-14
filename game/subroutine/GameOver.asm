sub_GameOver:

    ;; For now, just reset the game
    JMP RESET

    ;; Draw GAME OVER tiles over game screen
    ;; If player score is larger than high score
    ;; Overwrite high score with player score
    ;; If player presses either A or START
    ;; Initiate start screen routine (no hard reset as that resets the high score as well)
    ;; [@TODO]
    
    ;; Return
    RTS