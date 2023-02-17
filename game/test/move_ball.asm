
    ;; check if position should be updated (ie. has nmi happened yet)
    LDA ball_update_position
    BNE +

        ;; update the low byte
        LDA ball_ypos_lo
        CLC
        ADC #BALL_SPEED_LO
        STA ball_ypos_lo

        ;; update the high byte with carry
        LDA ball_ypos_hi
        ADC #BALL_SPEED_HI
        STA ball_ypos_hi

        ;; Don't update position again until next frame
        INC ball_update_position
    +

    ;; Add to sprite buffer
    LDX sprite_ram_pointer
    LDA ball_ypos_hi
    STA SPRITE_RAM,x
    INX
    LDA #BALL_TILE_CHR
    STA SPRITE_RAM,x
    INX
    LDA #BALL_ATTR
    STA SPRITE_RAM,x
    INX
    LDA ball_xpos_hi
    STA SPRITE_RAM,x
    INX
    STX sprite_ram_pointer

