
;; Random bleepy noises

    LDA do_beeps
    BEQ +continue
    
    CMP #$02
    BNE +beep
   
+stopBeep:
    LDA #$00
    STA do_beeps
    LDA #$08
    STA APU_STATUS
    STA NOISE_LENGTH
    JSR sub_BackgroundNoise
    JMP +continue
    
+beep:
    LDA #$01
    STA APU_STATUS
    LDA soft_pulse1
    STA PULSE1_VOLUME
    JSR sub_GetRandomNumber
    STA PULSE1_TIMER_LO
    JSR sub_GetRandomNumber
    AND #$01
    STA PULSE1_TIMER_HI

+continue:

