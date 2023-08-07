
sub_PreloadSfxFromX:
    
    ;; Load sample X into sfx address (low byte)
    LDA tbl_Sfx_lo,x
    STA sfx_address
    
    ;; Load sample X into sfx address (high byte)
    LDA tbl_Sfx_hi,x
    STA sfx_address+1
    
    ;; Start SFX timer
    LDA #$01
    STA sfx_timer
    
    RTS
    
    