
;; Handling of level win state
lbl_LevelWin:

    ;; Freeze the ball
    LDA ball_flags
    ORA #FREEZE_BALL
    STA ball_flags

    ;; Disable noise channel
    LDA #$01
    STA noise_muted
    
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
    
    ;; Quick and dirty way to remove ball from screen
    LDA #$EF
    STA ADDR_SPRITERAM+4
    STA ADDR_SPRITERAM+5
    STA ADDR_SPRITERAM+6
    STA ADDR_SPRITERAM+7
    
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
    
    ;; Initiate frequency beeps (@TODO)
    LDA #$0F
    STA sfx_sweep_count
    -sweepsLoop:
    
        ;; Reset volume for new sweep
        LDA sfx_sweep_count
        STA sfx_sweep_next_volume
        
        ;; Set up single sweep loop
        LDX #$00
        -sweepLoop:
        
            ;; Set current low frequency
            LDA tbl_SweepFrequency,x
            STA sfx_sweep_frequency
            
            ;; Set current volume
            LDY sfx_sweep_next_volume
            STY sfx_sweep_volume
            
            ;; Wait for NMI to play sfx
            JSR sub_WaitForNMI

            ;; Prepare next volume
            LDA tbl_SweepVolume,y
            STA sfx_sweep_next_volume
            
            ;; Clear pointer, except for sprite-zero and ball
            LDA #$08
            STA sprite_ram_pointer

            ;; Load animations (if any)
            TXA
            PHA
            JSR sub_LoadAnimations
            PLA
            TAX

            ;; Play next frequency
            INX
            CPX #$05
        BNE -sweepLoop
        
        ;; Play next sweep
        DEC sfx_sweep_count
    BNE -sweepsLoop

    ;; Wait a few frames
    LDX #$2D
    JSR sub_WaitXFrames
    

    ;; Play the end level sweep sound effect, and
    ;; initiate bonus score routine
    LDA #$B8
    STA soft_pulse1

    LDA #$01
    STA APU_STATUS
    STA do_beeps

    -bonusPointsLoop:
        ;; Check how many bonus points to subtract
        ;; (either the max, or what's left)
        LDA ball_bonus
        ORA ball_bonus+1
        BNE +fullBonus
        LDA ball_bonus+2
        CMP #BONUS_COUNTDOWN_PER_FRAME
        BCC +partBonus

        +fullBonus:
        LDA #BONUS_COUNTDOWN_PER_FRAME
        +partBonus:

        ;; Put value that's added to score on the stack
        TAX
        LDA tbl_BonusToScore,x
        PHA

        ;; Subtract X-register from bonus
        JSR sub_SubtractXFromBonus

        ;; Get value from stack and add it to the score
        PLA
        JSR sub_AddAccumulatorToScore

        ;; Wait for NMI twice
        JSR sub_WaitForNMI
        JSR sub_WaitForNMI

        ;; Check if bonus countdown is done
        LDA ball_bonus
        ORA ball_bonus+1
        ORA ball_bonus+2
    BNE -bonusPointsLoop

    ;; fade out the beeping
    LDX #$08
    -fadeOutLoop:
        JSR sub_WaitForNMI
        JSR sub_WaitForNMI
        DEC soft_pulse1
        DEX
    BNE -fadeOutLoop

    ;; Stop random beeping
    LDA #$02
    STA do_beeps
    
    ;; Wait a few frames
    LDX #$30
    JSR sub_WaitXFrames

    ;; Load next level
    JMP lbl_InitiateLevelLoad
    
