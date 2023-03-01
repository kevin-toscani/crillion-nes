
;; Subroutine to evaluate the colliding tile type and take its
;; corresponding action (move block, kill player, ...)
;; - Expects X-register to be the ADDR_SCREENTILERAM offset
;; - Uses zp variable colliding_tile

sub_EvaluateTileType:

    ;; Check if collided tile is a color block
    LDA colliding_tile
    AND #IS_COLOR_BLOCK
    BEQ +checkIfPaintBlock
        ;; It's a color block. Check if the colors match
        JSR sub_ColorsMatch
        BEQ +
            ;; Colors don't match - return
            RTS
        +

        ;; Colors match. Destroy color block
        ;; - Add the tiles that need updating to ppu buffer
        ;; - Load destruction animation on tile
        ;; - Write #$00 in tile type ram (makes not-solid)
        ;; - Update attribute table accordingly through ppu buffer
        ;; - If there are no color blocks left:
        ;;   - Freeze ball
        ;;   - Initiate level-win state
        ;; (@TODO)
        RTS
    +checkIfPaintBlock:
    
    ;; Check if collided tile is a paint block
    LDA colliding_tile
    AND #IS_PAINT_BLOCK
    BEQ +checkIfDeathBlock
        ;; It's a paint block. Update ball color
        ;; Save x-register
        TXA
        PHA

        ;; Get tile color
        LDA colliding_tile
        AND #%00001110
        ASL
        ASL
        ASL
        ASL
        STA temp

        ;; Apply tile color to ball
        LDA ball_flags
        AND #%00011111
        ORA temp
        STA ball_flags
        JSR sub_ColorizeBall

        ;; Restore x-register
        PLA
        TAX

        ;; Return
        RTS
    +checkIfDeathBlock:

    ;; Check if collided tile is a death block
    LDA colliding_tile
    AND #IS_DEATH_BLOCK
    BEQ +checkIfMoveBlock
        ;; It is a death block. Kill player and return (@TODO)
;        LDA ball_flags
;        ORA #%00000101
;        STA ball_flags
        RTS
    +checkIfMoveBlock:

    ;; Check if collided tile is a move block
    LDA colliding_tile
    AND #IS_MOVE_BLOCK
    BEQ +done
        ;; It is a move block. Check if colors match
        JSR sub_ColorsMatch
        BEQ +
            ;; Colors don't match - return
            RTS
        +

        ;; Colors match.
        ;; - Check if next tile is a solid
        ;; - If not, move the tile:
        ;;   - Add the tiles that need updating to ppu buffer
        ;;   - Add move tile sprite over the original tile
        ;;   - Initiate moving the sprite that way for 16px
        ;;   - Write #$00 in tile type ram (makes not-solid)
        ;;   - Update attribute table accordingly through ppu buffer
        ;; - After moving the sprite, in a different routine:
        ;;   - Add move tile data on the new tile location
        ;;   - Write the original tile type data on new position in ram
        ;;   - Destroy sprite
        ;;   - Update attribute table accordingly through ppu buffer
        ;; (@TODO)
        RTS
    +done:

    ;; Return
    RTS

