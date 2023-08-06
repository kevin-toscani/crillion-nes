
;; Write the byte in temp+2 and the ppu address (temp)
;; to a buffer, so NMI can update it before the next frame

sub_WriteByteToPPUBuffer:

    ;; Prevent updating until full 3-byte buffer is filled,
    ;; so that graphics won't glitch out if NMI happens during
    ;; updating the buffer
    LDA #$00
    STA ppu_buffer_update

    ;; Check if buffer full; if so, wait a frame and force update
    LDY ppu_buffer_pointer
    CPY #$60
    BNE +
        INC ppu_buffer_update
        JSR sub_WaitForVBlank
    +

    ;; Add ppu_addr high byte to buffer
    LDA temp
    STA ppu_buffer,y

    ;; Add ppu_addr low byte to buffer
    INY
    LDA temp+1
    STA ppu_buffer,y

    ;; Add ppu_data to buffer
    INY
    LDA temp+2
    STA ppu_buffer,y

    ;; Update buffer pointer
    INY
    STY ppu_buffer_pointer

    ;; Tell NMI to update next round
    INC ppu_buffer_update

    ;; Return
    RTS

