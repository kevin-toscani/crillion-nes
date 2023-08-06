
;; Tell ball to nudge
sub_InitiateNudge:
    STA ball_flags
    LDA #NUDGE_FRAMES
    STA nudge_timer
    RTS

