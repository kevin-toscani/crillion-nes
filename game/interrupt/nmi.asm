
    ;; Check if ppu_buffer needs updating
    LDA ppu_buffer_update
    BNE +
        JMP +no_ppu_buffer_update
    +

    ;; Reset ppu control register and mask
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
    LDA #$00

;; Continue other NMI stuff
+no_ppu_buffer_update:

    ;; Reset sprite RAM, draw sprites
    STA OAM_ADDR
    LDA #$02
    STA OAM_DMA

    ;; Decrease explosion and move block timers
    LDY #MAX_ANIMATIONS
    LDX #$00
    -
        LDA explosion_timer,x
        BEQ +
            DEC explosion_timer,x
        +

        LDA move_block_timer,x
        BEQ +
            DEC move_block_timer,x
        +
        
        INX
        DEY
        BEQ +done
    JMP -
+done:

    ;; Decrease nudge timer
    LDA nudge_timer
    BEQ +
        DEC nudge_timer
    +

    ;; Decrease bonus timer
    LDA bonus_timer
    BEQ +
        DEC bonus_timer
    +

    ;; Decrease kill timer
    LDA kill_timer
    BEQ +
        DEC kill_timer
    +

    ;; Play background noise
    LDA screen_mode
    AND #IS_GAME_SCREEN
    BEQ +
        .include "game/include/main/background_sound.asm"
    +

    ;; Test: random bleeps (disabled)
    .include "game/test/random_descending_bleeps.asm"
    
    ;; Test: explosion sound
    .include "game/test/nmi_explosion.asm"
    

