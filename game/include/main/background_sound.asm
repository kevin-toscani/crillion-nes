
    ;; If noise is muted, no noise should play
    LDA noise_muted
    BEQ +
        LDA #$30
        STA NOISE_VOLUME
        JMP +endNoise
    +
    
    ;; At random times, set max_noise period to $03-$0A
    LDA max_noise
    BNE +
        JSR sub_GetRandomNumber
        AND #%11101111
        BNE +
        
        LDA frame_counter
        STA random_seed
        JSR sub_GetRandomNumber
        AND #$07
        ADC #$03
        STA max_noise
        LDA #$01
        STA sweep_noise
        LDA #$34
        STA NOISE_VOLUME
    +

    ;; if sweep noise = $00: constant noise
    ;; else if sweep noise > $80: decrease pitch
    ;; else: increase pitch
    LDA sweep_noise
    BEQ +constantNoise
    BMI +decreaseNoise

;; Sweep noise up to max noise pitch
+increaseNoise:
    DEC current_noise
    LDA current_noise
    STA NOISE_PERIOD
    CMP max_noise
    BNE +
        LDA #$00
        STA sweep_noise
        LDA #$0A
        STA noise_timer
    +
    JMP +endNoise

;; Keep noise at constant pitch
+constantNoise:
    LDA max_noise
    BEQ +endNoise

    LDA noise_timer
    BNE +
        LDA #$80
        STA sweep_noise
        JMP +endNoise
    +
    DEC noise_timer
    JMP +endNoise

;; Sweep noise down to initial pitch
+decreaseNoise:
    INC current_noise
    LDA current_noise
    STA NOISE_PERIOD
    CMP #$0E
    BNE +endNoise

    JSR sub_BackgroundNoise
    LDA #$00
    STA max_noise
    STA sweep_noise

+endNoise:

