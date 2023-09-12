
lbl_GameWin:

    ;; Tell the game that it has been won
    INC game_won
    INC sfx_endgame_enabled
    
    ;; Clear out game screen
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
    
    ;; Do a flashy screen and play a frequency sweep at the same time
    LDX #$00
    -endSweepsLoop:
        ;; Reset frequency
        LDA #$00
        STA sfx_endgame_p1_rest
        STA sfx_endgame_p2_rest
        LDA #$08
        STA sfx_endgame_p1_freq_hi
        LDA #$7A
        STA sfx_endgame_p1_freq_lo
        LDA #$09
        STA sfx_endgame_p2_freq_hi
        LDA #$3A
        STA sfx_endgame_p2_freq_lo
        
        ;; Get current sweep length
        LDA tbl_EndSweepLength,x
        STA temp+5
        LDY #$00
        -endSweepLoop:

            LDA frame_counter
            AND #$01
            BEQ +playNote

                ;; Get background color from table
                TXA
                PHA
                INC endgame_palette_timer
                LDA endgame_palette_timer
                AND #$0F
                TAX
                LDA tbl_EndGamePalette,x
                STA temp+2
                PLA
                TAX
            
                ;; Put background color in PPU buffer
                TYA
                PHA
                LDA #$3F
                STA temp
                LDA #$00
                STA temp+1
                JSR sub_WriteByteToPPUBuffer
                LDA #$0D
                STA temp+1
                JSR sub_WriteByteToPPUBuffer
                LDA #$19
                STA temp+1
                JSR sub_WriteByteToPPUBuffer
                PLA
                TAY

            +playNote:
            ;; Play the note
            JSR sub_WaitForNMI
            
            ;; Prepare the next note
            LDA sfx_endgame_p1_rest
            CLC
            ADC tbl_EndSweepFreqDeltaRest,x
            STA sfx_endgame_p1_rest
            LDA sfx_endgame_p1_freq_lo
            ADC tbl_EndSweepFreqDeltaLo,x
            STA sfx_endgame_p1_freq_lo
            LDA sfx_endgame_p1_freq_hi
            ADC #$00
            STA sfx_endgame_p1_freq_hi
            
            LDA sfx_endgame_p2_rest
            SEC
            SBC tbl_EndSweepFreqDeltaRest,x
            STA sfx_endgame_p2_rest
            LDA sfx_endgame_p2_freq_lo
            SBC tbl_EndSweepFreqDeltaLo,x
            STA sfx_endgame_p2_freq_lo
            LDA sfx_endgame_p2_freq_hi
            SBC #$00
            STA sfx_endgame_p2_freq_hi

            ;; Do next frequency in the sweep
            INY
            CPY temp+5
        BNE -endSweepLoop
        
        INX
        CPX #$12
        BEQ +disableSfx
    JMP -endSweepsLoop

    ;; Stop endgame sweep
    +disableSfx:
    LDA #$FF
    STA sfx_endgame_enabled
    
    ;; Wait a little
    LDX #$10
    JSR sub_WaitXFrames

    ;; Initiate the game over sequence
    JMP lbl_GameOver

