
    ;; Check if ppu_buffer needs updating
    LDA ppu_buffer_update
    BNE +
        JMP +no_ppu_buffer_update
    +

    ;; Reset ppu control register, mask and scrolling position
    LDX #$00
    STX PPU_CTRL
    STX PPU_MASK

    ;; Set up loop
    -
        ;; Reset hi/lo latch
        BIT PPU_STATUS

        ;; Write ppu_buffer hi and lo addresss to PPU_ADDR
        LDA ppu_buffer,x
        STA PPU_ADDR
        INX
        LDA ppu_buffer,x
        STA PPU_ADDR

        ;; Write ppu_buffer data to PPU_ADDR
        INX
        LDA ppu_buffer,x
        STA PPU_DATA

        ;; Check if updating is done (eg. X is at pointer)
        INX
        CPX ppu_buffer_pointer
        BEQ +
    JMP -
+

    ;; Reset ppu buffer update and pointer
    LDA #$00
    STA ppu_buffer_update
    STA ppu_buffer_pointer
    
    ;; Reset scrolling position
    STA PPU_SCROLL
    STA PPU_SCROLL

    ;; Restore ppu control register and mask
    LDA #%10010000
    STA PPU_CTRL
    LDA soft_ppu_mask
    STA PPU_MASK

;; Continue other NMI stuff
+no_ppu_buffer_update:
