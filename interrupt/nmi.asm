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
    ;STA PPU_CRTL
    LDA soft_ppu_mask
    STA PPU_MASK
    
    
    ;; Additional PPU updates go here

    

;; This is what happens when we forced nmi skip
+force_skip_nmi:

    ;; Increase frame counters
    INC frame_counter
    INC frame_counter_60
    
    ;; Increase second counter (if 60 frames have passed)
    LDA frame_counter_60
    CMP #60
    BNE +
        INC second_counter+1
        BNE ++
            INC second_counter
        ++
        LDA #$00
        STA frame_counter_60
    +

    ;; Don't skip next NMI request
    LDA #$00
    STA skip_nmi

    ;; Restore X, Y and PC from stack
    PLP
    PLA
    TYA
    PLA
    TXA

+skip_nmi:
    ;; Restore accumulator from stack
    PLA

    ;; Return
    RTI
