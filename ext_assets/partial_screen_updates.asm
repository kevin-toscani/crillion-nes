;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Concept: partial screen updates
;;  
;;  When a tile, color, etc. needs to be updated, NMI needs to take
;;  care of this. So the course of action will be something like
;;  this.
;;  
;;  When a PPU update is needed, we add this to a buffer variable.
;;  When NMI hits, this buffer gets written to the PPU and cleared.
;;
;;  Added a check so PPU updates are forced when there are 16 updates
;;  present in the buffer, so that NMI doesn't run out of cycles.
;;  This may cause slowdown, but we'll need to experience that in
;;  practice and optimize accordingly.
;;
;;  This script makes no distinction between different types of PPU
;;  updates, like attributes, tiles or patterns. Exception are sprite
;;  updates, as those are streamed to PPU all at once. We'll
;;  dedicate 64 bytes of MISC RAM for that, preferably at $0200.
;;
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In RAM, set up ppu buffer variables

;; update and pointer in ZP
ppu_buffer_update   .db 1
ppu_buffer_pointer  .db 1

;; buffer itself in MISC
ppu_buffer          .db 48


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Within main game loop, when tile needs updating:

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
    LDA #$20
    STA ppu_buffer,y

    ;; Add ppu_addr low byte to buffer
    INY
    LDA #$20
    STA ppu_buffer,y

    ;; Add ppu_data (in this case, chr tile id) to buffer
    INY
    LDA #$3C ; ppu_data
    STA ppu_buffer,y

    ;; Update buffer pointer
    INY
    STY ppu_buffer_pointer

    ;; Tell NMI to update next round
    INC ppu_buffer_update


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Within NMI, do the update if needed

    ;; Check if ppu_buffer needs updating
    LDA ppu_buffer_update
    BNE +
        JMP +no_ppu_buffer_update
    +

    ;; Set up loop
    LDX #$00
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

;; Continue other NMI stuff
+no_ppu_buffer_update:
