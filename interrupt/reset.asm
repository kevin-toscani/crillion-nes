
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; include/reset.asm
;;
;; Basic reset script. Disables rendering, clears memory, moves
;; sprites off screen and (re)initializes the game.
;;
;;

    ;; Ignore IRQ's
    SEI

    ;; Disable decimal mode
    CLD

    ;; Disable APU frame IRQ
    LDX #$40
    STX APU_FC

    ;; Set up the stack
    LDX #$FF
    TXS

    ;; Disable NMI, rendering, DMC and APU IRQ's
    INX
    STX PPU_CTRL
    STX PPU_MASK
    STX APU_CTRL
    STX APU_STATUS

    ;; Clear the vBlank flag
    BIT PPU_STATUS

    ;; Wait for vBlank
    JSR sub_WaitForVBlank

    ;; Clear memory
    -clrMem:
        ;; Move sprites off screen
        LDA #$FE
        STA ADDR_SPRITERAM,x

        ;; Clear other memory
        ;; Skip first eleven bytes
        ;; (cold boot check and high score)
        LDA #$00
        CPX #$0B
        BCC +
            STA ADDR_ZEROPAGE,x
        +
        STA $0100,x
        STA $0300,x
        STA $0400,x
        STA $0500,x
        STA $0600,x
        STA $0700,x

        ;; Clear next in line
        INX
    BNE -clrMem

    ;; Wait for vBlank
    JSR sub_WaitForVBlank

	;; Turn on NMI, set foreground $0000, background $1000
    LDA #%10010000
    STA PPU_CTRL
    
    ;; Reset PPU scroll pointer
    LDY #0
    STY $2005
    STY $2005
    
    ;; Initialize game
    .include "game/interrupt/reset.asm"

