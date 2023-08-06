
;; Play background noise
sub_BackgroundNoise:
    LDA #$32
    STA NOISE_VOLUME
    LDA #$0E
    STA NOISE_PERIOD
    STA current_noise
    RTS

