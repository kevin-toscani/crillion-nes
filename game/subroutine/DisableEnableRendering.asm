
;; Subroutines to disable or enable screen rendering

sub_DisableRendering:
    ;; Force NMI skip, disable rendering
	LDA #$01
	STA force_skip_nmi
    JSR sub_WaitForVBlank
    LDA soft_ppu_mask
    AND #%11100111
    STA PPU_MASK
    STA soft_ppu_mask
    JSR sub_WaitForVBlank
    RTS

sub_EnableRendering:
    ;; Enable rendering
	LDA #$00
	STA PPU_SCROLL
	STA PPU_SCROLL
    JSR sub_WaitForVBlank
	STA force_skip_nmi
    LDA soft_ppu_mask
    ORA #%00011000
    STA soft_ppu_mask
    STA PPU_MASK
    JSR sub_WaitForVBlank
    RTS

