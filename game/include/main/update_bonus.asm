
;; Update the bonus counter on screen

    ;; If bonus = 000, skip decreasing
    LDA ball_bonus
    ORA ball_bonus+1
    ORA ball_bonus+2
    BEQ +done

    ;; Check if bonus timer is done yet
    LDA bonus_timer
    BNE +done

    ;; Bonus timer is done
    ;; Reset bonus timer
    LDA #BONUS_FRAMES
    STA bonus_timer
    
    ;; Subtract one from ball bonus ones
    LDX #$01
    JSR sub_SubtractXFromBonus

+done:

