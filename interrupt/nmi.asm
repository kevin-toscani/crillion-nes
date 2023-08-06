
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; include/nmi.asm
;;
;; Non-maskable interrupt script. This script is being executed
;; when vBlank hits.
;;
;;

    ;; Preserve accumulator through stack
    PHA

    ;; Should NMI be skipped?
    LDA skip_nmi
    BEQ +
        JMP +skip_nmi
    +

    ;; When in NMI, skip additional NMI requests
    LDA #$01
    STA skip_nmi

    ;; Preserve X, Y, and PC through stack
    TXA
    PHA
    TYA
    PHA
    PHP
    
    ;; Check forced NMI skip
    LDA force_skip_nmi
    BEQ +
        JMP +force_skip_nmi
    +

    ;; Update PPU mask
    ;LDA #$00
    ;STA PPU_CTRL
    LDA soft_ppu_mask
    STA PPU_MASK
    
    
    ;; Additional PPU updates go here
    .include "game/interrupt/nmi.asm"

;; This is what happens when we forced nmi skip
+force_skip_nmi:

    ;; Increase frame timers
    INC frame_counter

    ;; reset sprites_update_position
    LDA #$00
    STA sprites_update_position

    ;; Don't skip next NMI request
    LDA #$00
    STA skip_nmi
    STA check_nmi

    ;; Restore X, Y and PC from stack
    PLP
    PLA
    TAY
    PLA
    TAX

+skip_nmi:
    ;; Restore accumulator from stack
    PLA

    ;; Return
    RTI

