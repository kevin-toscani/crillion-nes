
;; Draws a tile using temp and temp+1 as the PPU address, and temp+8 as the CHR tile id

sub_DrawTileTemp018:
    LDA temp
    STA ppu_buffer,y
    INY
    LDA temp+1
    STA ppu_buffer,y
    INY
    LDA temp+8
    STA ppu_buffer,y
    INY
    RTS

