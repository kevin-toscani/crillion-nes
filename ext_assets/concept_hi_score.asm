;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  concept_hi_score.asm
;;
;;  These script snippets, when put into place, should achieve the
;;  following:
;;
;;  1) It allows the game to distinguish between a cold and a warm
;;     boot, so it can keep the high score in memory when pressing
;;     the reset button, but nulls it on power off.
;;
;;  2) It adds a high score system, where the high score is drawn on
;;     the title screen.
;;
;;  These scripts are untested and prone to errors, which will be
;;  resolved upon implementation.
;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; in global zp ram, on top, add:

    sentience       .dsb 5
    hi_score        .dsb 6



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; modify in global reset:

        ;; Clear other memory
        ;; Skip first twelve bytes
        ;; (cold boot check and high score)
        LDA #$00
        CPX #$0A
        BCS +
            STA ADDR_ZEROPAGE,x
        +
        STA $0100,x
        STA $0300,x
        STA $0400,x
        STA $0500,x
        STA $0600,x
        STA $0700,x



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; in game reset, add:

    ;; Check for cold or warm boot, by comparing
    ;; the 6-byte RAM and ROM sentience string.
    LDX #$00
    LDY #$00
    -
        LDA tbl_Sentient,x
        CMP sentience,x
        BEQ +
            INY
        +
        STA sentience,x
        INX
        CPX #$05
    BNE -

    ;; If system is sentient (warm boot), Y is zero now.
    CPY #$00
    BEQ +

        ;; System not sentient (cold boot)
        ;; Set default hi score to 200.000
        LDA #$02
        STA hi_score
        LDA #$00
        STA hi_score+1
        STA hi_score+2
        STA hi_score+3
        STA hi_score+4
        STA hi_score+5
    +



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; in game over routine, add:

    ;; Check if current score exceeds high score
    LDX #$00
    -checkHiScoreLoop:

        ;; Compare ball score digit with high score digit
        LDA ball_score,x
        CMP hi_score,x

        ;; If the score digit is lower, the entire score must
        ;; be lower, so we can skip checking the other digits
        BCC +hiScoreHandlingDone

        ;; If the score digit is equal, check the next digit
        BEQ +checkNextDigit

        ;; If the score digit is higher, update the high score
        JMP +updateHighScore

        ;; Check the next digit (if any digits are left)
        +checkNextDigit:
        INX
        CPX #$06
    BNE -checkHiScoreLoop

    ;; All digits are equal? What are the odds!
    ;; Either way, we don't have to update the high score,
    ;; although doing so won't do any harm, so if we need
    ;; three more bytes at the cost of a couple dozen
    ;; cycles, we can skip this jump.
    JMP +hiScoreHandlingDone

    ;; Transfer the ball score values to the high score values
    +updateHighScore:
    LDX #$00
    -
        LDA ball_score,x
        STA hi_score,x
        INX
        CPX #$06
    BNE -

    ;; The high score has been handled now. Hurrah!
    +hiScoreHandlingDone:



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; change tbl_IntroScreenData (may need finetuning):

    ;; Set PPU address $20A4 and draw
    .db #$60, #$A4
    .db #_1, #_DOT, #_L, #_E, #_V, #_E, #_L, #_COLON

    ;; Set PPU address $20C6 and draw
    .db #$60, #$C6
    .db #_0, #_1    

    ;; Set PPU address $20B4 and draw
    .db #$60, #$B4
    .db #_H, #_I, #_SPACE, #_S, #_C, #_O, #_R, #_E, #_COLON

    ;; Set PPU address $20D6 and draw high score
    .db #$60, #$D6, #$3E
    .db #_2, #_0, #_0, #_0, #_0, #_0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; in subroutine LoadIntroScreen, add:

    ;; If current byte is #$3E, draw high score
    CMP #$3E
    BNE +
        LDY #$00
        -
            LDA hi_score,y
            CLC
            ADC #1
            STA PPU_DATA
            INY
            CMP #$06
        BNE -
        INX
        JMP -loop_IntroScreenData
    +



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; in game tables, add:

tbl_Sentient: .db #$C0, #$FF, #$EE, #$54, #$07

