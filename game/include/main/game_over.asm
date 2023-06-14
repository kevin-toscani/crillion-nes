lbl_GameOver:

    ;; Disable noise channel
    LDA #$00
    STA APU_STATUS
    STA NOISE_VOLUME
    
    ;; Do blinds effect
    JSR sub_BlindsEffect

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
