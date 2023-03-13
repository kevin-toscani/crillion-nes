
;; Subroutine to convert the ball's position to a tile type
;; - Expects temp to be y-position of ball within game area
;; - Expects temp+1 to be x-position of ball within game area
;; - Puts result in accumulator and zp variable
;; - Corrupts X-register

sub_ConvertXYToTileType:
    LDA temp+1
    LSR
    LSR
    LSR
    LSR
    STA temp+9
    LDA temp
    AND #%11110000
    CLC
    ADC temp+9
    STA temp+9
    TAX
    LDA tile_type, x
    STA colliding_tile
    RTS

