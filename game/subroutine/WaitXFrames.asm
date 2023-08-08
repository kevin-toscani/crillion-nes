
sub_WaitXFrames:
    
    ;; Push X to stack
    TXA
    PHA
    
    ;; Wait for NMI
    JSR sub_WaitForNMI

    ;; Clear pointer, except for sprite-zero and ball
    LDA #$08
    STA sprite_ram_pointer

    ;; Load animations (if any)
    JSR sub_LoadAnimations
    
    ;; Restore original X
    PLA
    TAX
    
    ;; Check if all X frames have passed
    DEX
    BNE sub_WaitXFrames
    
    ;; Return
    RTS

