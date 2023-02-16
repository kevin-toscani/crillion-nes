    ;; If START button is pressed
    LDA buttons_pressed
    AND #BUTTON_START
    BNE +
        JMP +end
    +
    
    ;; Prevent updating until full 3-byte buffer is filled,
    ;; so that graphics won't glitch out if NMI happens during
    ;; updating the buffer
    LDA #$00
    STA ppu_buffer_update

    ;; Check if buffer full; if so, wait a frame and force update
    LDY ppu_buffer_pointer
    CPY #$30
    BNE +
        INC ppu_buffer_update
        JSR sub_WaitForVBlank
    +

    ;; Add ppu_addr high byte to buffer
    LDA #$21
    STA ppu_buffer,y

    ;; Add ppu_addr low byte to buffer
    INY
    LDA #$E0
    STA ppu_buffer,y

    ;; Add ppu_data (in this case, chr tile id $3C) to buffer
    INY
    LDA #$28
    STA ppu_buffer,y

    ;; Update buffer pointer
    INY
    STY ppu_buffer_pointer

    ;; Tell NMI to update next round
    INC ppu_buffer_update

   
+end: