sub_DisableRendering:
    ;; Force NMI skip, disable rendering
	LDA #$01
	STA force_skip_nmi
    LDA soft_ppu_mask
    AND #%11100111
    STA soft_ppu_mask
    JSR sub_WaitForVBlank
    RTS

sub_EnableRendering:
    ;; Enable rendering
    LDA soft_ppu_mask
    ORA #%00011110
    STA soft_ppu_mask
	LDA #$00
	STA PPU_SCROLL
	STA PPU_SCROLL
	STA force_skip_nmi
    JSR sub_WaitForVBlank
    RTS
