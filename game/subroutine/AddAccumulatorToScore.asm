
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  sub_AddAccumulatorToScore.asm
;;
;;  Take the accumulator, convert it to decimals, store those in a six-digit
;;  value called add_to_score. Then, byte for byte, add this value to the
;;  actual score.
;;
;;


sub_AddAccumulatorToScore:

    ;; Clear old add_to_score
    LDX #$05
    LDY #$00
    -
        STY add_to_score,x
        DEX
    BPL -

    ;; Set accumulator to add_to_score variables
    ;; Check and update 100s
    -checkHundreds:
        CMP #100
        BCC +checkTens
            SEC
            SBC #100
            INC add_to_score+3
            JMP -checkHundreds
        +checkTens:

    ;; Check and update 10s
    -checkTens:
        CMP #10
        BCC +setOnes
            SEC
            SBC #10
            INC add_to_score+4
            JMP -checkTens
        +setOnes:

    ;; We're left with 1s
    STA add_to_score+5

    ;; Store the value of the score's second digit (i.e. the 10k
    ;; digit) so we can check if this has changed later
    LDA ball_score+1
    STA temp+5

    ;; Byte for byte, add add_to_score to ball_score
    LDA #$00
    STA ppu_buffer_update
    LDY ppu_buffer_pointer
    LDX #$05
    -
        LDA add_to_score,x
        CLC
        ADC ball_score,x
        CMP #10
        BCC +
            SEC
            SBC #10
            INC ball_score-1,x
        +
        
        ;; Update new score digit
        STA ball_score,x

        ;; Update score tile in PPU
        LDA #$20
        STA ppu_buffer,y
        INY
        TXA
        CLC
        ADC #$83
        STA ppu_buffer,y
        INY
        LDA ball_score,x
        CLC
        ADC #$01
        STA ppu_buffer,y
        INY

        ;; Check next digit (if any left)
        DEX
        BMI +done
    JMP -

+done:

    ;; Check if the second digit has changed
    LDA temp+5
    CMP ball_score+1
    BEQ +updateBufferPointer

    ;; Second digit changed; check if player has seven lives
    LDA ball_lives
    CMP #$07
    BEQ +updateBufferPointer

    ;; Player does not have seven lives: add a life
    INC ball_lives

    ;; Update the lives digit in the HUD via PPU buffer 
    LDA #$20
    STA ppu_buffer,y
    INY
    LDA #$92
    STA ppu_buffer,y
    INY
    LDA ball_lives
    CLC
    ADC #$01
    STA ppu_buffer,y
    INY

+updateBufferPointer:
    ;; Update PPU buffer pointer and status
    STY ppu_buffer_pointer
    LDA #$01
    STA ppu_buffer_update

    ;; Done: return 
    RTS

