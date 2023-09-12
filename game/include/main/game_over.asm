
;; Game over sequence
lbl_GameOver:

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

    ;; The high score has been handled now.
    +hiScoreHandlingDone:
    
    ;; Disable noise channel
    LDA #$00
    STA APU_STATUS
    STA NOISE_VOLUME
    
    ;; Do blinds effect
    LDA game_won
    BNE +
        JSR sub_BlindsEffect
    +
    LDA #$00
    STA game_won

    ;; Disable draw after HUD to disable screen
    JSR sub_WaitForNMI
    -
        LDA PPU_STATUS
        AND #SPRITE_0_HIT
    BNE -
    -
        LDA PPU_STATUS
        AND #SPRITE_0_HIT
    BEQ -
    JSR sub_Waste6
    JSR sub_Waste5
    JSR sub_Waste4
    JSR sub_Waste3
    JSR sub_Waste1
    JSR sub_Waste0
    LDA #$00
    STA PPU_MASK
    
    ;; Remove game area from view
    BIT PPU_STATUS
    LDA #$20
    STA PPU_ADDR
    LDA #$A0
    STA PPU_ADDR
    LDA #$00
    LDX #$16
    -xLoop:
        LDY #$20
        -yLoop:
            STA PPU_DATA
            DEY
        BNE -yLoop
        DEX
    BNE -xLoop
    
    ;; Set lives to 0
    BIT PPU_STATUS
    LDA #$20
    STA PPU_ADDR
    LDA #$92
    STA PPU_ADDR
    LDA #$01
    STA PPU_DATA
    
    ;; Reset scroll
    LDA #$00
    STA PPU_SCROLL
    STA PPU_SCROLL
    JSR sub_WaitForNMI

    ;; Pause for a little while
    LDX #$18
    -
        JSR sub_WaitForNMI
        DEX
    BNE -
            
    ;; Do flash effect
    JSR sub_FlashEffect

    ;; Draw GAME OVER tiles over game screen
    LDA #$21
    STA temp
    LDA #$EB
    STA temp+1

    LDX #$00
    -gameOverTileLoop:
        LDA tbl_GameOver,x
        STA temp+2
        JSR sub_WriteByteToPPUBuffer
        INC temp+1
        INX
        CPX #$0A
    BNE -gameOverTileLoop
    
    ;; Update GAME OVER attributes on game screen
    LDA #$23
    STA temp
    LDA #$DA
    STA temp+1
    LDA #$AA
    STA temp+2
    LDX #$04
    -
        JSR sub_WriteByteToPPUBuffer
        INC temp+1
        DEX
    BNE -
    JSR sub_WaitForNMI
    
   
    ;; If player score is larger than high score
    ;; Overwrite high score with player score
    ;; [@TODO]
    
    
    ;; If player presses either A or START, (soft) reset the game
    -checkController:
        JSR sub_ReadController
        LDA buttons_held
        AND #%10010000
    BEQ -checkController
    JMP lbl_SoftReset

