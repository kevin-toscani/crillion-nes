
;; Handling of level win state
lbl_LevelWin:

    ;; Freeze the ball
    LDA ball_flags
    ORA #FREEZE_BALL
    STA ball_flags

    ;; Disable noise channel
    LDA #$00
    STA APU_STATUS
    STA NOISE_VOLUME
    
    ;; Wait a few frames
    LDX #$18
    JSR sub_WaitXFrames

    ;; Set null tile color to yellow
    LDA #$3F
    STA temp
    LDA #$02
    STA temp+1
    LDA #$38
    STA temp+2
    JSR sub_WriteByteToPPUBuffer
    
    ;; Wait a few frames
    LDX #$10
    JSR sub_WaitXFrames
    
    ;; Restore null tile color to dark blue
    LDA #$3F
    STA temp
    LDA #$02
    STA temp+1
    LDA #$12
    STA temp+2
    JSR sub_WriteByteToPPUBuffer
    
    ;; Play the end level sweep sound effect (@TODO)

    ;; Initiate bonus score routine (@TODO)

    ;; Wait a few frames
    LDX #$18
    JSR sub_WaitXFrames

    ;; Load next level
    JMP lbl_InitiateLevelLoad
    
